Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7BA28
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 04:31:51 +0000 (UTC)
Received: from [127.0.0.1] ([73.223.250.219])
	(authenticated bits=0)
	by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2BK4Bcj21617553
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 19 Dec 2022 20:11:39 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2BK4Bcj21617553
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2022120601; t=1671509502;
	bh=4fkXFH0sW5ZGQC33LFxm1QzpGPoew8Q0xRPlzvCq1nQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Pi5fP/o5I2P1JC2H3FoVs5Rgkk/IsKgVSe499ohBroXNnQWUaqlfizGtLhY3jnIH4
	 BVBgKJ2JdCZvkXA3PqduOSIWKj97/qSH8ucxQPkuAgaTHgCKLVeDHijKmjdRiBus/C
	 16cOgJMYRHlr4XtkFoneI3WWGJ42aNqBth5twrPgBZgE1aBbUTvGjRWgVWfG7WZCjO
	 lrETkKASOjTTNZAwHR21esKipc8XRi4fA6dqXXVJ754vl0xn7lKq4sMWuiwn7k4GoL
	 V/e8eZL5+3/AiYXJuq1pDKyIwAV3HuzExlLYUPrpVOJcHxHnOZHz6ZEJlPIh0h3Yhn
	 1tde5K+LCO3wQ==
Date: Mon, 19 Dec 2022 20:11:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
        corbet@lwn.net, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>,
        vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 01/12] crypto: Remove u128 usage
User-Agent: K-9 Mail for Android
In-Reply-To: <Y6ExF8mchgYiiRB0@gondor.apana.org.au>
References: <20221219153525.632521981@infradead.org> <20221219154118.889543494@infradead.org> <Y6CJsWBhcbKatZNg@zx2c4.com> <Y6CYu4skFFMopU+g@hirez.programming.kicks-ass.net> <CAHmME9oCBgNCfYFxirA-fdarGip5MvOG-iUxT=2HC=iSXRMH-Q@mail.gmail.com> <Y6ExF8mchgYiiRB0@gondor.apana.org.au>
Message-ID: <7C23FA3C-A967-4BAE-970B-5E6FAF4DE037@zytor.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 19, 2022 7:50:47 PM PST, Herbert Xu <herbert@gondor=2Eapana=2Eo=
rg=2Eau> wrote:
>On Mon, Dec 19, 2022 at 06:03:04PM +0100, Jason A=2E Donenfeld wrote:
>>
>> Is there a patch at the end of the series that adds it back in to use u=
128?
>
>Could we do some ifdef trickery to reduce the amount of code churn
>please? Changing everything away from u128 and then back to it seems
>silly=2E
>
>Thanks,

Seems like "merging common code snippets" is something we at least used to=
 do with single patches=2E=2E=2E
