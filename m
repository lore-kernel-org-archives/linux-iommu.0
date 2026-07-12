Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B8342CB0
	for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893761; cv=none; b=EOyVG8iEcE33XnZnNN86HHOFV2wEtqqGyDRn5pX9CgWkIErrHlBgAZvYOn+vCw+m8bHbsXxkD/v48p+acJlURpIbZmqJFnPK7zQmdHTOXkZazelq6anJMc0KcskFrEIiO+ghzbHKU4ueXuXpAGV/Opc4snrZ7XZ+HgxpgOVbScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893761; c=relaxed/simple;
	bh=9doQrKp6KwSDaJ9VqtVfvX30Yv5ebNu4lugCON+hGRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igczfkKX7aj4hy3wXY025VfpOQz54XYOB1QQTemCbTr+ddxF6xi+uuEsdwJZXIWwjF2z6GD9Bawv0lxkXsIdpNpTW7daN907aEbuzOvM7JAHvdiaWDEgLHVWeiuFKkFyb1IQKBs4peCbLw67xv9GOSXG+3jhs2TJRpKKoCf1wEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e6TLkdq1; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e6TLkdq1"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfad59921so18493221cf.0
        for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 15:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783893756; x=1784498556; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FvL6EjrEIuF0wC64QnMQO+VDujPOa7rrdCG0RMcrsPU=;
        b=e6TLkdq1zFpe3AybdlcnrylaNO5kZpDB9HE6W/JGguWGBwL34NTfUarbLr1w89uBXv
         Lr3vGTGsObvvFUV23xIMGq2s7L/cLG9KNyMP4uqPOfCW3ePjjBtiSmUMSjJwIQ5bnjg1
         VbcDSZs4L4lW30H5Bx9wHY8cEoTUA26xKIqcs3ASG/BF4zPTRCIvzbi4uL1+lnf87oWm
         lUbET6UP4kCoxf7ptvc0Xt1EJtmJpAtp7Zyig3v6VNUM1J7FDpuGoOIcGuNBRFkPW39a
         pHHT7aazyRaJoLbHCeiJBaPT/zMf1ajfmI1+hMSTlTr79xya3OgjWOvPRCpKnWyuhUtT
         LCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893756; x=1784498556;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvL6EjrEIuF0wC64QnMQO+VDujPOa7rrdCG0RMcrsPU=;
        b=jH2Y8b2EP765WQeOb6QXUAYpsCePKGLvmiiEmtfi3Ose5ZqiPQestu07YWXF5DNamm
         1GsM6belP/jbmK7so7B2Fqop3c4S1O4/uuaNpnpfGnxLuJ88X6yFUeJl6vLUuArZ5fm6
         NRKCTGo4vYAgIiXM50WO5BdN09W7hihWNnjhBc9vIuOV5MLtpRggYo9pbCjJybqLbpCD
         Hx/UV20cI5kNXT8Eq/PdfLJKc40IVuCFMJvTTIW7837HHNHFJP+hpySTGoOFGRq2IHDH
         wgKbrDOvjQhUb8O4joqzwoCJRgQ10gO4EmEyKP8eY0X+hoHtpLWJprcyDAU/9/CE4SoG
         4u3w==
X-Forwarded-Encrypted: i=1; AHgh+Rrn+X3O2NfsgSJOsWLUqyGlxowzRYHtLsS419U9C0QRY8R6Z2/G4rfgSq6UkaTkQL2ca187yA==@lists.linux.dev
X-Gm-Message-State: AOJu0YztJDtzJ8wbfxd4cGLobvh6I3tDzOcG3eIcXyjq7zSGRJFP80uS
	4/jd4leXNrB/KuJnTieg1HHX1R03NWsqtDwJ+jXIN0Kr8LRBUQkTgwNg6Zw0XZTIMr0=
X-Gm-Gg: AfdE7cn0QeFwegFuh9ua9ECWuPXVE74yHGWbiN9ysd1ag9kbaqgT1/XxXl85rEY4zeL
	BQZWG5JuDKovWAmc1a6CMWnUFFnlpJXDAYGF9+AmuHImpSwD4giEVSKH/bLDrWQQyceeNORFz2q
	yV5Em8tb2VqgeyQoBMbq1t8nn9YZOeSOx5Ws9YcLEaeLajeJEh1qv3KLNUuU10cn/Jbb74DDlNd
	PW3WtqLxgbmj7dbSMgScH23VJlQe2xYhEQlpqluyo+qj+Wfs+u5DcQ8PNQ8zCYRN0b63ay1CBXU
	Zm42/aVPWWXixYYviVQvzeejPXGBoqTxlnmY3p9uRzaE8H9rPCdy/0HnMDMSl1aYwQpxlKXKxWe
	6mIK/3HP6FJkebiM6L3koZvI32U4AK2sYSmAR+YSRZBBb2vOFZaJHYJsi5YEQ
X-Received: by 2002:a05:622a:15c4:b0:51a:8e07:59d5 with SMTP id d75a77b69052e-51cbf071548mr72240201cf.12.1783893756428;
        Sun, 12 Jul 2026 15:02:36 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b78sm113643606d6.18.2026.07.12.15.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:02:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wj2Fu-0000000BnNB-2edV;
	Sun, 12 Jul 2026 19:02:34 -0300
Date: Sun, 12 Jul 2026 19:02:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	nick.hollinghurst@raspberrypi.com
Subject: Re: [PATCH 2/6] iommupt: allow full-table contiguous leaves in unit
 tests
Message-ID: <20260712220234.GB1835788@ziepe.ca>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
 <20260712-bcm2712-iommu-submit-v1-2-80e10cdde2ea@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-2-80e10cdde2ea@reactivated.net>

On Sun, Jul 12, 2026 at 10:18:52PM +0100, Daniel Drake wrote:
> The generic_pt tests currently assume that a format should never support
> a contiguous page size that spans the entire mapping range of the table
> it resides in.
> 
> This assumption breaks for BCM2712, which has a 2-level page table.
> Level 1 entries cover 4MB of memory via their corresponding Level 0
> table pages. There is a concept of a 4MB largepage, but that is
> represented as a Level 1 entry pointing at a Level 0 table with the 1024
> usual PTEs with an additional largepage hint applied (for TLB
> optimization purposes). Unlike typical IOMMUs, it is not possible to have
> the Level 1 entry point directly at a 4MB chunk without the need for
> Level 0 mapping.
> 
> This BCM2712 format is well supported by generic_pt: SZ_4M can be
> advertised as a possible size at Level 0 (so that the iommu core feeds
> it 4MB-aligned mapping requests where possible), and drivers can also
> advertise that *all* leaf entries are installed at Level 0. This indicates
> that the tests are overly strict.
> 
> Transform the test to become a validation of the driver's routing intent:
> for every advertised page size, check that pt_pgsz_lg2_to_level() maps that
> size back to the table level under test. This is roughly what the original
> tests were doing, but also allows the BCM2712 case to pass.

Seems fine, but I wonder if it should be conditional on the format
somehow, I put it in to detect mistakes on what was the universal case
that nothing would do this.

Either way

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
