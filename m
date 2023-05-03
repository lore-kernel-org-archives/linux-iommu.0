Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00487DF4E
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 18:24:08 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6436e075166so251445b3a.0
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683138248; x=1685730248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAaHXuopg20H7kDrY4ngFywwBOIWWtTHOJdh9Kk4ti8=;
        b=aB33hUnZnfHPZlWWtIoWkOnjjHisPYabb6S2uWTBQ8h3onE+k8lH1fwWNrmP3+C2Ae
         V9xYfHUAfa1MQR5bGsnZZI/T3EfAtEbMB7LJgZA6S5DUFfa3NoHlKU045MUvM3dSPcwJ
         O9knvzOZHAicKc7Q1U9prQ5QYBA7iuXytpIxNnq+/0XAMdmK6s/cx66iKx/7bF6fFMVt
         9qvyKftWjNhL52s2yKIZb6lNZsILUvRPIJqsyqINqcoQfODMA3flr2J6lxf4LYnNwpJG
         HZgaEjG650bHbl05TVNvOqMZG18RkP9d2mBdzyVqPL8pMYePQurNMT2j8/2P3LbRKc10
         RP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138248; x=1685730248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAaHXuopg20H7kDrY4ngFywwBOIWWtTHOJdh9Kk4ti8=;
        b=OQ0hclYgySWCRWf6uTM8vdA6BIZUgEMvnNYoM4qP4T78/P2EBtg5lZ2muWwh1shRXG
         RI86CxadpLftaor33k3vjVJ/zbgYB8uTGtQdTq2dJm2d8ORsaGHAcYYFbdegIfEaoIqB
         WcY8YwHd/naIQ/r+Py9WjTpYpDx0bRWicpWcRWJkLC5EULHO3mzzBXorStQ/jvcVD2V8
         HyCtgpRayRvPO6DsyDAjRF3U4nDnfayTl1/FMC1mSsXm4HYvPzRZkLEVehMU+FOkqyQG
         wvhjfgT6JyEAYxppw1DjvjDLLaZBUP5hsyoMfmows7SUZbLglwakJjTMtgqATq0wDXMV
         Y5BA==
X-Gm-Message-State: AC+VfDyHiHlWJpTrd7LpiTS2M4iHuZ2mrYQkxy5q+bGRuA4AjN3VxKdO
	ImkNt7B1qhLmiYevzE2qc/s=
X-Google-Smtp-Source: ACHHUZ6SJEEQ8QvbsKtdJRVXR1zPnkUl+hGGIJ5sn55EaO+j6xudf8VpDqWbOhAMlICayQOL4hheYg==
X-Received: by 2002:a05:6a20:1616:b0:f3:b764:5de3 with SMTP id l22-20020a056a20161600b000f3b7645de3mr27371733pzj.48.1683138248162;
        Wed, 03 May 2023 11:24:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id c17-20020a056a000ad100b005ae02dc5b94sm23989633pfl.219.2023.05.03.11.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:24:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 May 2023 08:24:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
	akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	keescook@chromium.org, ndesaulniers@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <ZFKmxVXlk9xkQoPB@slm.duckdns.org>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <ZFKfG7bVuOAk27yP@moria.home.lan>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFKfG7bVuOAk27yP@moria.home.lan>

Hello,

On Wed, May 03, 2023 at 01:51:23PM -0400, Kent Overstreet wrote:
> Do you have example output?

Not right now. It's from many months ago. It's just a script I could find
easily.

> TBH I'm skeptical that it's even possible to do full memory allocation
> profiling with tracing/bpf, due to recursive memory allocations and
> needing an index of outstanding allcations.

There are some issues e.g. w/ lossy updates which should be fixed from BPF
side but we do run BPF on every single packet and IO on most of our
machines, so basing this argument on whether tracking all memory allocations
from BPF is possible is probably not a winning strategy for this proposal.

Thanks.

-- 
tejun
