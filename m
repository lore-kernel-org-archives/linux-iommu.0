Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83693947B5
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785302153; cv=none; b=bqc+r975pdRQIKvmb1eMHQGSPCbPNgSkHg9Wp33w5+Cl7ZB7tRwmaedyPp2ewlQe95zf7URgNEQVYHg4C3NLg2cW0PBJ3ypEaA8xp0ioYOCHWMNLuljhHa6Va5RBjXtDr6xtCoyL6dxSZ0KnGq2J93nvGdgynysjBpeqnPcupwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785302153; c=relaxed/simple;
	bh=arvW8DEjXjLKtC6BO9hMfUJE3a2BUgzm9bXYSPBa1uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0X/uLjye9ku56Ih9Uvv6sFONyV2t+zU/jWDHDTxg+A7TqMsYdS/PQFuHihNFXhdKdQ0eeK/3nHU7QU2Bqkj5mzwVVkiOvYLAYJFT6Gwhuusm6/+U0FgrjX2qjtGa3wnQn0nBPgIJhtyhE5o7ajt8hW6f0MVjVpsp/1DC1sjWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MzXOD1ll; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MzXOD1ll"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab97c86bdso42515ad.1
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 22:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785302152; x=1785906952; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oi3z5OGmFTcAu6ua8IwxSpW3BCYGUVzFL1IOvsxUp2E=;
        b=MzXOD1llvR3bsjn1l6VsFR5XX4+1n2bQy3SDnyAcdIIz6ghYz0SvFt6ukOhmSkruKZ
         wbMydvf7SYJMS2nWsDS7PlgqFOkT+JtG6M0CRt9jDy6tlCTl+HG8QFJNrhmOVjQlN4Eq
         IzzDAwWe7hMOI50vAAMmNzzDvgfugDIPseT9ev8nI3LElNXs65VtlkU+40TaZKGrLmRm
         jYmB/TH6ThlvCk3SSuHVZXEpz4I2YNsG5RgbOeqq4J1zO8O6p5YYuAm6MdnNHEBc8bC9
         BMhZ8lCo1K0QkqJf4qtFyG7rZwTfcqf8H10bDVlALedkrihUoSS31JzWFhPjd40Znymv
         Z41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785302152; x=1785906952;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oi3z5OGmFTcAu6ua8IwxSpW3BCYGUVzFL1IOvsxUp2E=;
        b=pLBU/A+K89hKCR+J/X1m1P7CDisgvT1Q7ISLLEfkMamsK7uavM1O6upMs0ZINWGDF4
         xdujmkeYCc7AUkM4yDZE0qLMaQRzE//lqDPC3AapUWZ/Vbkj2/mIvBdDiC8h2qWbR2od
         qYLfpjnD+WeN3wzf2W0TNI0fsnMcAWymhZCipS/dF6JZyfI2mNfp30t4AwoM9yEVVUSx
         JigiuhFTsWQPudIe7xpWL6mPhkkHCiJUFNRO3GWEgNyfi9lvsPaZH3OaoNdvYhDBJT5i
         AQlKT1wrqMc9q7ti8bpNlgBilvOIph2hP9HP52Kj9UnOv6bKtByC/HpnrzvA1av9gKm2
         4LGA==
X-Forwarded-Encrypted: i=1; AHgh+Rqe7xDuvorwi6yWLQOKlxLUEkNPWPiB05FigmWbpgEVI8s7Y0WFa5rn1E4SAl3sNe8X3DTwZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/spTtriR6nlMnP6ctwh8bEw7c+R+b/PJSUH/yLA4rw9biVvL/
	rRAKsJD3GGwbTwyMjvXyayDIlhSrZ1STNPtVvdX5vg69ELWNJeuCECVZ9R3JHE7lwg==
X-Gm-Gg: AR+sD11bVKl34KUlgtybricYIgkHSYPg1CZ8B773AiojcB8MW0+1BOvn7zMOU7VOTc4
	bppUop/erwEcGqLDtpCIGm46LXlcd9+v6kIOgeFKFT8PESEnkvpbYtdjupMNMlaMRj+KcB0qNgj
	rRPKKlckhNTNUGuzRLH/ghg+/eUg7Z+Lbljb+JSLD83Ppw0VJXBbfxj60u3gHJZnYaNAboggNOo
	qQJ7vGAxJHTY60sRMKKS7hN6hZIdaMKCVjCBkQSNvAs3Eh63l4JmM/3SrInx+0WCufD4aN03YNp
	wQAR39kWqtZnX78Z8CLdK/UshDD5NrjcEapQNP5j3xdvkRKdjp7Ro2twbgYFdakMAcUewpAMOrI
	ANuKVHG/gaRInDyq9HPBPbE6OkPV6CDEUvjobmxYeF2cmJ9lemnkVBcaM9aGjfBd3FNAfTHnb5w
	AiULiCrRa/0dgbcVzqtDTfodPmY0LXSGaQ4XDjccavWxE6+xj+xNEYPMArovABNW6fK4uT1BDc6
	SYTHTcSI7ydVHszfNt2JTA=
X-Received: by 2002:a17:902:e014:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2d026c5c8c4mr1262155ad.0.1785302151338;
        Tue, 28 Jul 2026 22:15:51 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0051591sm789220b3a.19.2026.07.28.22.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:15:50 -0700 (PDT)
Date: Wed, 29 Jul 2026 05:15:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	bhelgaas@google.com, kevin.tian@intel.com, kees@kernel.org,
	smostafa@google.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com
Subject: Re: [PATCH v2 03/11] iommu/arm-smmu-v3: Add
 arm_smmu_drain_queue_for_iopf() helper
Message-ID: <ammMf5z-Gl-Wygk6@google.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
 <amkcQRVylEe_t-yP@google.com>
 <amkqZbPJs9qly4pH@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amkqZbPJs9qly4pH@nvidia.com>

On Tue, Jul 28, 2026 at 03:17:09PM -0700, Nicolin Chen wrote:
> On Tue, Jul 28, 2026 at 09:16:49PM +0000, Pranjal Shrivastava wrote:
> > The following is a unified drain_queue helper, that also attempts to
> > address Sashiko's concerns. This applies on top of my runtime PM v9
> > series [1], please see if it works for you:
> > 
> > Subject: [PATCH] iommu/arm-smmu-v3: Add a unified arm_smmu_drain_queue()  helper
> > 
> > Introduce a unified arm_smmu_drain_queue() helper to replace queue
> > specific polling loops. The helper handles both snapshot-based cohort
> > draining (for IOPF) and full queue draining (required for Runtime PM).
> > 
> > The Runtime PM explicitly gates the CMDQ (via CMDQ_PROD_STOP_FLAG) prior
> > to draining, this allows a single, snapshot-based target to natively
> > handle all drain scenarios.
> 
> [..] 
> >  	queue_poll_init(smmu, &qp);
> > +	qp.wfe = is_cmdq;
> 
> The callers of this drain() will be RPM and PRI, either of which
> needs busy-waiting. So, I have added a different drain() helper.
> I run Sashiko locally; it also gives a clean result.
> 

Ahh my bad. I meant to set qp.wfe = false, is_cmdq is a rebase remnant...

> Commit:
> https://github.com/nicolinc/iommufd/commit/d10325ff40fd45c476bc98d484d8dd2cdc7fdf95
> 

Thanks for sharing this, looks good from the CMDQ side (since we call
this when new CMDQ submissions are gated).

For PRIQ/EVTQ, my only worry was the HW producing more events,
say Device A is detached (we call drain from attach_release) but Device B
(still attached) starts an agressive DMA with multiple PRI requests/evts.

Maybe we should go back to snapshot based polling for that?
Anyway, we can discuss this when the series is posted.

> This will be in my pri-v3 series:
> https://github.com/nicolinc/iommufd/commits/smmuv3_pri-v3
> 
> We have too many SMMUv3 under review now. So, I will post it once
> some of them are merged.
> 
> Nicolin

Thanks,
Praan
