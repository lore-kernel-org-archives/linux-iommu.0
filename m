Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86F328136C
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385845; cv=none; b=AgSGdcTtx+EgfgrEGwqwQwh37x7CfVnsqkG/j1FZqgozyOKQlz0qlG96FKwmYTPtHnxSRxiUhoMOJDRKTeObwQPxwHxZe/VVCwg2k9zBzI7ArEbUuK2EGT4NWuEjsx/PzXidh2Vf3+pIs3O6A4QIC/H/fQpMYPrcePBaZdLCnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385845; c=relaxed/simple;
	bh=ne8NvOAvFFZDyWLijTFkORn2krR9QgII4t00fOofTpM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sAOsZ57ezGwXy6fZd2ADFscahrzeHlRUX+QbC3is/wN6/eXfLauqNAq9tDZF9Tt12SFq+I5lLIl6FAzO5cVDgPVVt6DhfY77dfRM1RrorwYN5GrC1xWWcFX/PleXBlXoMr/majz2lnr58546SRwiQZp3/ra7aSdSKw6FfeVZVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfQt0ihC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfQt0ihC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765385843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4vjuiVWtSeDDJf5R2NBM1m79JOYpshPwskFvViMdAw=;
	b=TfQt0ihCEEGTZVl8sCSPDDiiK3wnMTiEzXBDIZqy2x9DVWsHhpnJ0uHDmqb01mIbwrbCKJ
	C9Op9xku4QTsTgwD3Ctxs27+co1kysKrxnnpPuvZvN2brN//bScwZ/fRnC8vYxZdOXFfjl
	vGjj3CyQk57Txk2BHMvNdVN/jBaDbqM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-8UGoFlWiO8e5Ww70ZS9Zqw-1; Wed, 10 Dec 2025 11:57:20 -0500
X-MC-Unique: 8UGoFlWiO8e5Ww70ZS9Zqw-1
X-Mimecast-MFC-AGG-ID: 8UGoFlWiO8e5Ww70ZS9Zqw_1765385840
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42e2e5ef669so5399883f8f.0
        for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 08:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765385840; x=1765990640;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4vjuiVWtSeDDJf5R2NBM1m79JOYpshPwskFvViMdAw=;
        b=aRpUiJSI68Eizh9oktbU3ljDxIWrd1QuNQOQZsx+J518sLManINQ5uOH8E/wKGz8cN
         pJLZdcho4Jgg8i+pADSTFpKjR1rGNO9BYmFjKQk9CZlAqEH+e5kNt5SEaGv16mRmzjdy
         RvJE3Jn5itRJH9dFHMcsAh7/wjdqOaTBEeV2j0AEptsiAPhIinF3bfAZG6yy29m0bn6P
         3o8qLBKUP1ovOKWjINzc/B3301x+e3rtxk/767jWPqeteSc58N0kIw3a+0MbKTI10Qb0
         NbuiRAjQ9jUJXtzP2LNw1fiJTwhzXTwMIKpl+85rO11iwujd+7hx4MjQHgBR/CmQYPB/
         vK8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFl0fw6RIVP8H4xJVTM3JQz9MtW6yT6Vu7qS0drPqk88X6X2nUoQ1hdtQeGziscujUZp+FlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeAvTMlgF17XVBITb450A585pZt1trRv3P21YCLrmXNb3HWUna
	qMGIP5VnO6hFjqYf3Iq+SWKKI9cEJJ0cafV4WiZW0VIdU7RVu+Fx9fIwoDFaekmN0vjzBKgS5PL
	S9DHPtLGeLGMn9/OXUYlHH4N10imAAjk/41NLTX/46WxdiHljgTLnTeWB
X-Gm-Gg: ASbGncv7M+Ju+f0pNE8tO9whx0QR9zHIWg1gToxkam6kYFcfNnfx6WiUY+tb652s5dJ
	1VeM+WePl0vvx1MJr92YHYYM/ftoFMdeHLt3q5LDVMFuHkBmWmUEmwl7F1tBCMM/Zp9BVrmooxe
	mzCSQYKgkpWsXYj4pipyUIbWpjLQASX28Sf4T9MpjdpEIWGEOOxEkWdUyM97jDDjH7RhpTTGczu
	Su+zSgTPWuBNoXe8sRz6eNMPj8Abr+ZvVJnm4s5rXEGxbTF0ncgRzzTa3rGUcA9EZISJv9f09mW
	Vho2V7WmR52jE74g01j3Ccfwvxld5kdGf8SXrkou/N7UMmRM55U197QsW8WU3aqY1Haj8qsoNY0
	N18xh6UKz3/tgklW1yE0AQ7V1tJJbn1+y/G62qQMR6sdhP2vHYGJcFc/ZLqY=
X-Received: by 2002:a05:600c:4703:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-47a8380c006mr28364475e9.11.1765385839638;
        Wed, 10 Dec 2025 08:57:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1ErKmvwfO917QfwpOmc3kdwchwTX5DWogSYZNPVxkP8iDCKVQ0toYxrjvCOwIlDXwEtINDA==
X-Received: by 2002:a05:600c:4703:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-47a8380c006mr28364255e9.11.1765385839191;
        Wed, 10 Dec 2025 08:57:19 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8837fdd5sm1473825e9.13.2025.12.10.08.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:57:18 -0800 (PST)
Date: Wed, 10 Dec 2025 17:57:17 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Keith Busch <kbusch@kernel.org>
cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>, 
    Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>, 
    Robin Murphy <robin.murphy@arm.com>, Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <aTlXuhmsil7YFKTR@kbusch-mbp>
Message-ID: <6cb5157f-c14b-5a86-c26d-50aaadf8d3ca@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <aTj-8-_tHHY7q5C0@kbusch-mbp> <acb053b0-fc08-91c6-c166-eebf26b5987e@redhat.com> <aTlXuhmsil7YFKTR@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jtAyD8oZBPSAkxNACYif5H5sAwymQ3u4ntyJFi6SssY_1765385840
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Dec 2025, Keith Busch wrote:
> On Wed, Dec 10, 2025 at 12:08:36PM +0100, Sebastian Ott wrote:
>> On Wed, 10 Dec 2025, Keith Busch wrote:
>>> On Tue, Dec 09, 2025 at 12:43:31PM +0100, Sebastian Ott wrote:
>>>> got the following warning after a kernel update on Thurstday, leading to a
>>>> panic and fs corruption. I didn't capture the first warning but I'm pretty
>>>> sure it was the same. It's reproducible but I didn't bisect since it
>>>> borked my fs. The only hint I can give is that v6.18 worked. Is this a
>>>> known issue? Anything I should try?
>>>
>>> Could you check if your nvme device supports SGLs? There are some new
>>> features in 6.19 that would allow merging IO that wouldn't have happened
>>> before. You can check from command line:
>>>
>>>  # nvme id-ctrl /dev/nvme0 | grep sgl
>>
>> # nvme id-ctrl /dev/nvme0n1 | grep sgl
>> sgls      : 0xf0002
>
> Oh neat, so you *do* support SGL. Not that it was required as arm64
> can support iommu granularities larger than the NVMe PRP unit, so the
> bug was possible to hit in either case for you (assuming the smmu was
> configured with 64k io page size).
>
> Anyway, thanks for the report, and sorry for the fs trouble the bug
> caused you.

No worries, it was a test system in need for an upgrade anyway.
Thanks for the quick fix!

> I'm working on a blktest to specifically target this
> condition so we don't regress again. I just need to make sure to run it
> on a system with iommu enabled (usually it's off on my test machine).

Great!

