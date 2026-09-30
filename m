Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A13B42F8
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806968; cv=none; b=RYr0JSQdTMtuVr+NdRpyTjKkfh/GVjCpS/T3PPT4Tem9AQTpVLb9zc+dzGwHJB4gmBGl2w5/AlGXPj/yn/yGU9FSfo+xbPuUO8sh4A92643HhMlM8EGXY10oArwlAutFMlVQ0t23IG13BSBNAiFHgA/wkMphcSWUVKYEaBUHbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806968; c=relaxed/simple;
	bh=QiyCOGVk9NFuf5TTipAKukE/ZuC+v6EkWxAF9sFyh0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jvkb2vxjmiESHod+HuehyidrrYl8mFKFcpAYy7YF1lP7A/B47VrSTrr4BGsyt6Zo8vppvdG4z3i9jONnp9UivB3L9FB4snoO7qpGHS1QP6jmbl0o/bLcR6bEQsyUv69W5KEdV024eGD2zTHVBNsBXjM7zlJameEfpAC3vHUBP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kUzV5gh8; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kUzV5gh8"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bcb929cceso1378164eec.0
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790806965; x=1791411765; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dMg/2qAnKkcsx9Xk/70p49vFtevOX5lNII6aXG4vSbg=;
        b=kUzV5gh8hsBXJgOAxAgUhlY11gFREyzldZLukNNN60oyZ1QNL57zCw907JT7SDq4HS
         C2e2aPC6N/ZTmJY8fSJUtwaG+9Lskt4TMPVV1fcSj2QhzYumXkfN93lPVgvRAmrbmsTg
         R5Q3tRjMsrnMHHa+R5T04nE78kPPP3/h+1VDovr/f6TnXDl2oGV4OJFx3WhhbuJnohpm
         +8uMgk+ktKWQsxWFx+dgtn+722gpqj1H8uesZuYaOxhPDWR3uq7esX94g6KmmE2utE8K
         NToCofQDBfq4FGTrpM8DTCyXHcZ9jYM4RcAuazx2NoUlzueTCUtvfuG1knomljjJoJS6
         mBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790806965; x=1791411765;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dMg/2qAnKkcsx9Xk/70p49vFtevOX5lNII6aXG4vSbg=;
        b=0NoOXK3S0iu80Gb+LDzojVXX1cGkQvS60+ZyFFdVp9lY6ebMmjlHKlg9n0rFfWEM1K
         Bsu88i/PP/JUtv057av2RFaB8ghCTAa4BhlHlmEehRTcO3BL/9PyHrR7B8qeTXDxToE1
         fugx0ck8RzPQZEBd0U55sdnclDvyQXcICgfDpNSGPu1RoKLoe5h7qm9ntswW0/QiiY+f
         PNyvqzZ5OosTuIYneYhX6wQqvGWPSDqqWKswm/IRCfIG+LC39dLs3HMQVS/WiCea4DgA
         f3iBQJTJyDvNUwXXj1oibT/VRtrssYTL13O0//3mQtqYuaDz4ZpWAren5eqFJUlVTnld
         WIxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPrAe4UJZ6LxiQSiLSeEafnsnN/ANvcrA80oN/LcpvaVc5jINT3btZMt3noJg5UNWIkiKi8g==@lists.linux.dev
X-Gm-Message-State: AFuF++lWZxtpMGaDNlRBPuyW0q244AUFHdraYv3B3dml/jsB5HWcVjwb
	B6CJFxYyvv8dC3Akp3V4v8wRz/fmMzZmgFQN30SQFTB9VdUBW9ob9NYut35iSHRW8/w=
X-Gm-Gg: AYBFou0GkNFWkTUHyEBNeVO1uSA0HNsP+zxzi6CQ4pNfWb06BMHnoO2iCaP/by11rl9
	FMNKw5OFW04wsWKqZ/DgY6PY99Pa9Wm5C/e9f0hBNI04VnXeuXV5bNeKvldlSnUsO9NWpLf7zt2
	Ex0lsi30dPmWlnEnwUtiGZ08gL6PxYygmePbuP1qBaAL6Y0IR6PFTHjqT5xSMUsfOjmV5kxauNY
	5e1At9AKvPKD4sU5pu2rqKNp+1rKs/UQKKZ5O7VDqkZ/tl7nJd7DpgfIH48NC/cZMILgpq58cIC
	OSYHoYXCYHPB7zfm2bkaRS/a2zC8qUht/9ySWt+OL4I0v5wrZNDCOmoxf+Ab+/oq3ZU3s+e3iHa
	pxyORICuFc6Ex8c3a066xECrO+SgbvtedbdAHfoQ4Kz40qEzynM5tEtaY48JdPaJOUscoAwMcU1
	ezfLE2qbZor04Hv+a7HqKcGzcn/gi9oJYcVcGAp0mt9fCm
X-Received: by 2002:a05:693c:895b:20b0:34c:803c:84d9 with SMTP id 5a478bee46e88-34cdb8e4c56mr2632442eec.13.1790806965368;
        Wed, 30 Sep 2026 15:22:45 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db0c89a80sm1640377eec.2.2026.09.30.15.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:22:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xC2hH-0000000Cgf4-1b8m;
	Wed, 30 Sep 2026 19:22:43 -0300
Date: Wed, 30 Sep 2026 19:22:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Make iommu-dma helpers private
Message-ID: <20260930222243.GA3019323@ziepe.ca>
References: <ddcc6f8487366211af0d81ad9af2376ec29d8460.1790596307.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddcc6f8487366211af0d81ad9af2376ec29d8460.1790596307.git.robin.murphy@arm.com>

On Mon, Sep 28, 2026 at 12:51:47PM +0100, Robin Murphy wrote:
> Most of iommu-dma's own internals were privatised a while ago, but
> there are still a couple of DMA-domain-specific helpers provided
> by the core code. These now definitely have no reason to be exposed
> publicly, so move their declarations into the private header.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c  | 1 +
>  drivers/iommu/iommu-priv.h | 4 ++++
>  include/linux/iommu.h      | 2 --
>  3 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
