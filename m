Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C80A3B
	for <iommu@lists.linux.dev>; Thu,  1 Sep 2022 08:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662019508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fAYRQilXBeVPqddsxUYpdqrwWan1aH9ZFdN7uQibkcg=;
	b=dEXbCdf+pMIyvOhREVLL9uIrKVCRrLyDoHHoVmWuAFxXwPaY1LbZ9jaQFCAzpj6IdM03J6
	ZfADA6Y1QpOvbOqpGpzd+NBYyzTD9cugJid0TqTsCc0iBGedtaWhjukmPtW0hfdYESot+z
	OYZUcCVfx6b4zkZZgdw1y8SL8KDftOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-194-3-PQhPGAOjKvNAmXLxddXQ-1; Thu, 01 Sep 2022 04:05:07 -0400
X-MC-Unique: 3-PQhPGAOjKvNAmXLxddXQ-1
Received: by mail-wr1-f72.google.com with SMTP id h16-20020adfaa90000000b00226e36cc014so1493135wrc.8
        for <iommu@lists.linux.dev>; Thu, 01 Sep 2022 01:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=fAYRQilXBeVPqddsxUYpdqrwWan1aH9ZFdN7uQibkcg=;
        b=Elx2Es9fjB/tKX/dGBahcrhuM+ZWn46UmRmOdYxP79DnIvdpssmVz2z3+7v0/J7wAo
         QakcOaZFN59kQJhD3eNDhUfFIuFEnDpnnCqNZLSDcMQk48RdUvSqld1c2rDVRr7aMBcf
         BvUSrXH5SdRdfy6LuSwEwuWWMyG2eh3X0lZclUvkz5y7vtv8JYJ0Jrv944VaMILObSKW
         u8//18QlH+rpyosQgcUG9aNEP2yEB3KHgR4Iaa4qnKexvPlL98EstbDjXDplCQv/aTt+
         BcUMtijzuBodskYl3C0rgrgAVrRHsQKjcIb5hYIi13/lQVZeVjuHiIhuGKm41LcLVxzG
         cZyA==
X-Gm-Message-State: ACgBeo1OGosxUafFI+MUjnPpzTefGL2sSS3w2gcrzSnQY0b7FvJnWTXb
	QhoqeV6T8zWGtn2qh/iXo+MDDPedmn9jSxh79LYtJI+wa/Tg5lizyEG1SvqkUdonKTQ0iA6SKV1
	SeBu8ZH0NtHmYkh8=
X-Received: by 2002:a05:6000:1e02:b0:226:f21c:e192 with SMTP id bj2-20020a0560001e0200b00226f21ce192mr2042399wrb.7.1662019506255;
        Thu, 01 Sep 2022 01:05:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5QM6ydwWB1hA+IwFTy9+Av+xz2gk8FSGg7uVj19TAsR85EeUD5rGAvr1bryTm2SFDb+vhc5g==
X-Received: by 2002:a05:6000:1e02:b0:226:f21c:e192 with SMTP id bj2-20020a0560001e0200b00226f21ce192mr2042345wrb.7.1662019505980;
        Thu, 01 Sep 2022 01:05:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id b8-20020adff908000000b00223a50b1be8sm14023827wrr.50.2022.09.01.01.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:05:05 -0700 (PDT)
Message-ID: <404e947a-e1b2-0fae-8b4f-6f2e3ba6328d@redhat.com>
Date: Thu, 1 Sep 2022 10:05:03 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 void@manifault.com, juri.lelli@redhat.com, ldufour@linux.ibm.com,
 peterx@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, changbin.du@intel.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 shakeelb@google.com, songmuchun@bytedance.com, arnd@arndb.de,
 jbaron@akamai.com, rientjes@google.com, minchan@google.com,
 kaleshsingh@google.com, kernel-team@android.com, linux-mm@kvack.org,
 iommu@lists.linux.dev, kasan-dev@googlegroups.com, io-uring@vger.kernel.org,
 linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20220830214919.53220-1-surenb@google.com>
 <Yw8P8xZ4zqu121xL@hirez.programming.kicks-ass.net>
 <20220831084230.3ti3vitrzhzsu3fs@moria.home.lan>
 <20220831101948.f3etturccmp5ovkl@suse.de> <Yw88RFuBgc7yFYxA@dhcp22.suse.cz>
 <20220831190154.qdlsxfamans3ya5j@moria.home.lan>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 00/30] Code tagging framework and applications
In-Reply-To: <20220831190154.qdlsxfamans3ya5j@moria.home.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31.08.22 21:01, Kent Overstreet wrote:
> On Wed, Aug 31, 2022 at 12:47:32PM +0200, Michal Hocko wrote:
>> On Wed 31-08-22 11:19:48, Mel Gorman wrote:
>>> Whatever asking for an explanation as to why equivalent functionality
>>> cannot not be created from ftrace/kprobe/eBPF/whatever is reasonable.
>>
>> Fully agreed and this is especially true for a change this size
>> 77 files changed, 3406 insertions(+), 703 deletions(-)
> 
> In the case of memory allocation accounting, you flat cannot do this with ftrace
> - you could maybe do a janky version that isn't fully accurate, much slower,
> more complicated for the developer to understand and debug and more complicated
> for the end user.
> 
> But please, I invite anyone who's actually been doing this with ftrace to
> demonstrate otherwise.
> 
> Ftrace just isn't the right tool for the job here - we're talking about adding
> per callsite accounting to some of the fastest fast paths in the kernel.
> 
> And the size of the changes for memory allocation accounting are much more
> reasonable:
>  33 files changed, 623 insertions(+), 99 deletions(-)
> 
> The code tagging library should exist anyways, it's been open coded half a dozen
> times in the kernel already.

Hi Kent,

independent of the other discussions, if it's open coded already, does
it make sense to factor that already-open-coded part out independently
of the remainder of the full series here?

[I didn't immediately spot if this series also attempts already to
replace that open-coded part]

-- 
Thanks,

David / dhildenb

