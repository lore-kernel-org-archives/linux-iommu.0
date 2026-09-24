Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8C4AE118
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272182; cv=none; b=Iqf2YIhiAwqlIrWI/d5ckWlulwlsU8oYTCxm0L/pZthj575E7eDKX3qaejJaJlp4VldFrckzh84QZ+aPjLbh3bpeQk9+RPSSE+Bce8p2jxwByzrZ3ro/1BmCFo8nPSyLob6mnkgjIXjJXQbhQjIOvRE9bK/rPVSHQ/LC6PCOqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272182; c=relaxed/simple;
	bh=TDcsYHIaw35uYfkUp8SSuaUhuxl/3WHswj8+KRQh5cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUzM3XiJOu6ZMipBcjhH5nOCdXb3tLYFjybbEafvK6oLMFPuilm/LRQysoYvTCgZKj8AesMzsW/g0ZkGqeEGd7DzTkGsg2VMZrSdOmrT9r4WtkUA2GEtnaEKd2pP84Op+a9WBjcmSUSRzIj6GLSGPw7fPr7mu/UjTk/JOKYW4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=faZ+4+Vg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faZ+4+Vg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d8facae850so6895ad.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790272181; x=1790876981; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dby+5gVayzal4X1RiSbAFD0yfNnYiqO5W3Aena5N53g=;
        b=faZ+4+VgLG2k0deDsUzbKoA4mb+zrHMFgYigW0veQxKPMqfvylDNzB0I/OBbtmnUyW
         z7kKXpww2dl8HBpXYFgHlKQfEJi9F7qbOv47Hiu1eyNjr8GwOr+mGxDjQv6gN5CPXb+o
         H1Xpi0Aa36T+CoRxRjuh2N9/0XVh7rMshNg4Yl2xnD1qkCf+WDRh584++c+c6HRXOtpJ
         zUQE6FX/27cEMc51AOeSzhEmtOH7nFf7bZ5E5Uvl5PSWXaM5Oe3Dq/4N16uUMNEtKYZC
         IYCHUPXAbZih0llFwdEtbGUzUc8RO+LI5cOpBB8AV5ifsW3rApwhtj//Y94gN7aWsLhp
         SfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790272181; x=1790876981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dby+5gVayzal4X1RiSbAFD0yfNnYiqO5W3Aena5N53g=;
        b=VhKRjByVKrE5hyPCH4fdUsn5hzKfAp/R/e/kvaii2/hMzCS2kvEqpQizUxJE4vTtsv
         ve2qn2N8JO8EzKwcYEz1AycO7HE8An5hbAj5iX+T24+ci9inlMtdp/UBWiWptq/DEy1y
         GtzVdM90WEcT9bx0yNUL25TLYSYNNViX6VEbAHL9A2JX0BE789szlkdoW7m/Qc3EICYL
         Z0EpwnInsQR9vv0HjC7x0sO/o2SZIFUfyggHXlptpfRgc4VyvuluCGyuFMoOPwzU2zJ3
         ylFjUGK0ILhxb3enwyhAZVZsQKz2JY1GaH/6QFaSxikr98UCRchtCBepGfFltv5F2zZk
         xaWg==
X-Forwarded-Encrypted: i=1; AKwUvBzi/pCiMVeBf0Lisa4DS6Id93BlzaQnkcgb4yESByhLUlV+jUAtGhoU2I/gRY6W06sNeVrv5Q==@lists.linux.dev
X-Gm-Message-State: AFuF++lq84b50JzLnGhRIimOKADVoE4/cYRtKi6e+ukww0SriTTNhR8/
	VV4ml0csDksw0tB1AwKBXKz5OhU0BNino5keTtkSSMOp88kAr6jReZ6DH129ymKWKA==
X-Gm-Gg: AYBFou1neAVeqGzqZCpJLbrnHUOQ81DL+fPvs1nIc2zcEH8fydbzbzDFENFyUZ9L4MH
	2wiwG6WPNQPVTmxMxe92nFcvgI0Pi4JssoBrAcQs281tNXth6XcXQG7v/yxbpcAmNJoMHLEMFw5
	edzIHD4F+tCGDLguHNdfEW5YowWQyes+lK2ltFwjJ21BDIbgi+i9IKclZ5qUqdMxA899pUJN/hm
	Yme1lNjiKuOeIBoRoUIzilncfPBlR7NNwvsTpw1utQAesKy1ITCYXpyPhsXqguBWAiPaBLe/Hhl
	dLEpy/xWkVZSOSpNfawolCWNkLpr2IhTvaChPWcJMqni+hftgj3p6ryAIOiYHptswYJHb8f/yvV
	fLFUFforMKGYXikhqaJdLsmv4ky3Hf4fXaof/fUwtqCecPAsKvcY9cF6/TgEyrskrOERHcV2URT
	kQCBDpxy7doCQMY5mtyRnEcwFIzmsfa/vmQqH0SBTY1jyifxkcVZXBWdqJiK+TXAbKTtVlfCkTM
	980BFHvj1FYlQ6kmDeeWUreMOrMsAlo3Ka51Ktv3o9RwGQ0ff4j82xBhexANccEDkaOGQ==
X-Received: by 2002:a17:903:1aee:b0:2dd:3a08:d47b with SMTP id d9443c01a7336-2df90f4fcbfmr274255ad.13.1790272179931;
        Thu, 24 Sep 2026 10:49:39 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b2235811sm595000a91.7.2026.09.24.10.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:49:39 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:49:35 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: John Starks <dev@jstarks.net>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, John Starks <jostarks@microsoft.com>
Subject: Re: [PATCH v5 15/18] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <arVYa_90j0oN1hnu@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-16-skhawaja@google.com>
 <goxdwq6ny332pnrojvp4nuz2mliofd3yxd73fpjnbesq3e34fe@jq4d7v7rbwx3>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <goxdwq6ny332pnrojvp4nuz2mliofd3yxd73fpjnbesq3e34fe@jq4d7v7rbwx3>

On Wed, Sep 23, 2026 at 04:59:30PM -0700, John Starks wrote:
>On Mon, Sep 21, 2026 at 12:48:31AM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>> +
>> +		/*
>> +		 * When this memory file was mapped it should be sealed and seal
>> +		 * should be sealed. This means that since mapping was done the
>> +		 * memory file was not grown or shrink and the pages being used
>> +		 * until now remain pinned and preserved.
>> +		 */
>> +		if ((pages->seals & req_seals) != req_seals) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
>
>Is this sealing business sufficient? Even with the specified
>seals, user mode can still punch a hole in the memfd after it
>has been mapped. This will disassociate those pages from the memfd
>but leave them referenced by the HWPT.

Nice catch. Since punch hole doesn't change size, the shrink/grow seals
will not stop that from happening.

Once the memfd is preserved it is frozen, so punch hole is not allowed
after that. To catch the punch hole between map and iommufd preserve, we
need a truncate count on the memfd that can be checked here. Or we can
iterate through the iopt pages and verify that they are still associated
with the preserved memfd, similar to how memfd preserve already loops
through all the pages. I am inclined towards the iterative solution as
it handles all the future cases.

I will fix this in the next revision.

Thanks,
Sami
>
>Then, when the memfd gets preserved, the hole will be filled
>by a new set of pages, and only those pages that will be
>preserved across the kexec. The original set, unless I'm missing
>something, will be dangling in the HWPT, allowing attached
>devices to DMA to the wrong memory.
