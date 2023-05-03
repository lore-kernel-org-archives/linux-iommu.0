Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D919DF67
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 20:04:34 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3023a56048bso5327902f8f.3
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683144272; x=1685736272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHU5powRCH79ePrW9PLsNOR73hzLy7pF/AR2cVrEP7A=;
        b=X9cvzf7QfWfANWyiwaBoFAaHPlX2qeqZu2VCK9dHuW20oD3qDZADVWlb+BtBIBdSiO
         2RDzvFggR0cV7IyIeCqHDf9vzAIbh3l8EKnAha85GOqZ/85Z2kV5iHi0HZA5hxN3WCiL
         NDBgwTKeSBh1uBp9ZRn5IcKnZwjB9Xw2FNCu3VPxcgaMe8gKOK7zMR3TIQzUlk13qk0g
         Oy/vqaLM0dX473ikdNYh4d6O6S61SceyugQ5rTKI7IbtLax4XorLUr0QhjWGkIK6Mm8g
         jmi9mu20BH7ourolp1eZoSnL7KPbf6yac3FZz/qPtTH6UuXviA7A9ThzGyGaLUXBvIEp
         nt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683144272; x=1685736272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHU5powRCH79ePrW9PLsNOR73hzLy7pF/AR2cVrEP7A=;
        b=P9FY/r7MtF39GGp07d4LkY8Za2FED/vWn8c366OQrTgfh+sVPSweinGUY8b1UsPSds
         Hj8JquCsbdH1EYm2sVB4inFpm51KowKE9fY7azv9O+pVXOo8ggHem3tEW5MKD9s/tL2p
         s6yvg3Qv2aZvraYsSiLiSfgVFChRSdJe6k5tKxlGkvSY/wn0HSco6Nd+6HPd8qNoTQs8
         Q5JzXx7PoRQyCu3u9MkCghpZkhRkWjJ/f3Wj+veJVMlHPw/M4sZf4aq7YIIkUin9gszy
         kZmpIHAhNLqrShnV4Ez1tWzMzaUx4FtuiSdOVVKttStzn2LcHTlp3TxAWldXB9wVl/0b
         VURw==
X-Gm-Message-State: AC+VfDw7PQ5ALkkwgiq3Jdcm0II8B94cKtVWQO0bK6Vwma++N2v/1prU
	UesyUqUqtBQKByPijIOHIWixys4kuG8/h6R/S4g=
X-Google-Smtp-Source: ACHHUZ7zpuOeQ2HlbzadDjdNCOqFD0VigwxXNnk7+zHC8ZwW/zidgTFIwlyp+cl7LdT9bLB6cLchW8xym2AySZY+Hm8=
X-Received: by 2002:a5d:5222:0:b0:2fa:27ef:93d7 with SMTP id
 i2-20020a5d5222000000b002fa27ef93d7mr907489wra.42.1683144272448; Wed, 03 May
 2023 13:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan> <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan> <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
In-Reply-To: <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Wed, 3 May 2023 22:04:21 +0200
Message-ID: <CAPAsAGxcCJai6PpTVOkqAB-vG+Q71hb1exsK79hJ7Kb2eKAtjA@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 3, 2023 at 6:35=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Kent.
>
> On Wed, May 03, 2023 at 04:05:08AM -0400, Kent Overstreet wrote:
> > No, we're still waiting on the tracing people to _demonstrate_, not
> > claim, that this is at all possible in a comparable way with tracing.
>
> So, we (meta) happen to do stuff like this all the time in the fleet to h=
unt
> down tricky persistent problems like memory leaks, ref leaks, what-have-y=
ou.
> In recent kernels, with kprobe and BPF, our ability to debug these sorts =
of
> problems has improved a great deal. Below, I'm attaching a bcc script I u=
sed
> to hunt down, IIRC, a double vfree. It's not exactly for a leak but leaks
> can follow the same pattern.
>

For leaks there is example bcc
https://github.com/iovisor/bcc/blob/master/tools/memleak.py
