Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05B10E5
	for <iommu@lists.linux.dev>; Fri,  2 Sep 2022 04:06:18 +0000 (UTC)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1E25A1C6992;
	Thu,  1 Sep 2022 23:19:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id A9ECF8000E;
	Thu,  1 Sep 2022 23:19:36 +0000 (UTC)
Message-ID: <c3a6e2d86724efd3ac4b94ca1975e23ddb26cc6f.camel@perches.com>
Subject: Re: [RFC PATCH 28/30] Improved symbolic error names
From: Joe Perches <joe@perches.com>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net,  willy@infradead.org, liam.howlett@oracle.com,
 void@manifault.com,  peterz@infradead.org, juri.lelli@redhat.com,
 ldufour@linux.ibm.com,  peterx@redhat.com, david@redhat.com,
 axboe@kernel.dk, mcgrof@kernel.org,  masahiroy@kernel.org,
 nathan@kernel.org, changbin.du@intel.com, ytcoode@gmail.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com,  elver@google.com, dvyukov@google.com,
 shakeelb@google.com,  songmuchun@bytedance.com, arnd@arndb.de,
 jbaron@akamai.com, rientjes@google.com,  minchan@google.com,
 kaleshsingh@google.com, kernel-team@android.com,  linux-mm@kvack.org,
 iommu@lists.linux.dev, kasan-dev@googlegroups.com, 
 io-uring@vger.kernel.org, linux-arch@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Sep 2022 16:19:35 -0700
In-Reply-To: <20220830214919.53220-29-surenb@google.com>
References: <20220830214919.53220-1-surenb@google.com>
	 <20220830214919.53220-29-surenb@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A9ECF8000E
X-Spam-Status: No, score=0.64
X-Stat-Signature: iwqjhu65bfnp7s38he58qcgfcrx3mruu
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18FfjZ7BuRv/DHsUMYX6e6vN/rFvSwIdRQ=
X-HE-Tag: 1662074376-819350

On Tue, 2022-08-30 at 14:49 -0700, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
>=20
> This patch adds per-error-site error codes, with error strings that
> include their file and line number.
>=20
> To use, change code that returns an error, e.g.
>     return -ENOMEM;
> to
>     return -ERR(ENOMEM);
>=20
> Then, errname() will return a string that includes the file and line
> number of the ERR() call, for example
>     printk("Got error %s!\n", errname(err));
> will result in
>     Got error ENOMEM at foo.c:1234

Why? Something wrong with just using %pe ?

	printk("Got error %pe at %s:%d!\n", ERR_PTR(err), __FILE__, __LINE__);

Likely __FILE__ and __LINE__ aren't particularly useful.

And using ERR would add rather a lot of bloat as each codetag_error_code
struct would be unique.

+#define ERR(_err)							\
+({									\
+	static struct codetag_error_code				\
+	__used								\
+	__section("error_code_tags")					\
+	__aligned(8) e =3D {						\
+		.str	=3D #_err " at " __FILE__ ":" __stringify(__LINE__),\
+		.err	=3D _err,						\
+	};								\
+									\
+	e.err;								\
+})

