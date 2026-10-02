Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A04FB9C9
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959674; cv=none; b=WWSiZSAuCtl+nOGBQKtCH4b54UNcnjf0Py7LV96sNGJjtdiPO3Zyf8f2MwWRpCuj+prfJNT7i4vUDzYW3/IPBIwf/zdieT3UMOa4iUNoAVl7VRsc52vmshe2gsMCUL+CSIy36/371h7tZ+rpJ6gXwWdus0wo6Zb09jOgj7Xky+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959674; c=relaxed/simple;
	bh=GfLGRzNdrUQtKcYv331zMoj3Gl5JEVaaZYE2NszLXF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3dPvFNCUtlReajoRXKoUojq24rCfkMy7OdHC4cdmEmgwLdFM0YfRYSmt8N1k0DUDatC0kJazzOMjaOuwiZKRCrryck8JujogWGwR+0Sxc8F26OpUt9RQBj5bRVZYhG5v4ipcMsw8MZg41uLKEGokFnSx6edZRTZJ+khysLRbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VUXVExKJ; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VUXVExKJ"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04edb5so2117248c88.2
        for <iommu@lists.linux.dev>; Fri, 02 Oct 2026 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790959670; x=1791564470; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M8FgFfsrFu7NaKoGhtbGJNDz2Gwi+BLzqOzLKsff8ag=;
        b=VUXVExKJdzjwxxUASQbA0olS6bdDtGiHPSVI8fkGytb6GlUpDko+osshnn8BB3MITT
         W0QMjNGdx9E9FYaDTVje3/HS47Z3QA9S3uVrkXiBgjXGhVaUHaOuA0La/FeMR6a3Qlz2
         4ty1exHbP0rY0MeLeIn+OERCcNDwELIp8535HamLsU7RyA0i5eI/MZHqVyxw9n+R6Lr8
         YwpSwL8dfW0im7rnAjO/eb63GbxAWZZaaLeULGKLPY59umRWeNxXaAKBatmGIKckdzLh
         1TyhCE7+dYs6DT2YdqOfOx7jOar+gW63UPjfolRKpPya1oXIz1w0MEsQlyTtxl5ZnsYj
         i/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790959670; x=1791564470;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8FgFfsrFu7NaKoGhtbGJNDz2Gwi+BLzqOzLKsff8ag=;
        b=Acs3aLsnWxk/tKYc2SyHZm4JFjIFoMfA7JmOWAEiWLa9rvAqA+1414L310viSviVRf
         v5qSvlXwF4b1Z9bVRNbrjrsVx31XIeiyAyhhcxQCEBLH8d7hrzkPP0Ufpb+jBOQB21i7
         /XzyxYioQfXmOgwSlpCmz8S8xPyq4NCVwZtMYuQjMs77fBcSNYcq4XclZVW+c+LhztII
         bZScjkHJtPsaTN0Xe8DbN/6mIIXTcOfNKc5a6Q8jqkv5B1Pi+d3CtOFxsLqVnLmerfy8
         aL2NU1Uiyxo1XUANR1sg+6kPrUXQkS1Kbwcx3i/wEKUrFz2WftApGK9zTJfw6MYjbC92
         P9/A==
X-Forwarded-Encrypted: i=1; AKwUvBwshdXwGcfZJImgXJSPokP4y8Z+00uQfQbvUi8dMopChhb0ETpXZZ1N5bLPi31MOkCMenY4vQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kh/CbNZtlBbrwNPz6SJuLlyJtYWkmXh0DBVbslm1NYzRKP0jGz
	VxklqRy4d/TE4sGJfkxf4K3kNlclp/mqV2qKaaylj6M3AijOmFMv+M3FI0jlUdEJNwI=
X-Gm-Gg: AYBFou3Q+nIkmnoZHShss5cY11qD5zwSv8nBHeX2VBFswP1JB48tOWKWZ85DCOUECnX
	byGT399Juu3DN5IFtH2LRpUauGRSj9DsmvbrqcXatMVGhxWKVdRcSMlS2UA5HganPI9NjPFq4Hy
	IEf5+5V1d4IULOTXJru45+avSx1mlvJtrVuK7mzOD9GiA5LRSe/BZG5+TxJihxj9xUD04d1jHZZ
	aV4bQ1IIJu4sPfAKJpMM6Excet7Pgh5EreAN0kT+l6DlDXG6nYwcUL6/Hcsfirdyl+jlZqHXQgl
	aXF2PaJehCsA/OZYp/VUecX/LZAkq+0x9bvkw9ifxq791AzLe6p/lOvy09n7gx9oSrwFMDaLAFX
	G9LCPy1CJFOwnkKTHzjsbRzl5uHHZ+RoOUk3R5lbNa5p0Sb5/+vICrO0s/Eb520Bqmm8RaZXOOC
	gv++o2Kw1OsVpPCR/fOqiafYI3SgaE0mhwDjSNM0b+hQb+
X-Received: by 2002:a05:7022:5f1c:b0:146:852d:60b7 with SMTP id a92af1059eb24-1508932185fmr1788544c88.8.1790959670092;
        Fri, 02 Oct 2026 09:47:50 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fee0afsm8489793c88.5.2026.10.02.09.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:47:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xCgQG-000000008FP-19Pb;
	Fri, 02 Oct 2026 13:47:48 -0300
Date: Fri, 2 Oct 2026 13:47:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <20261002164748.GD3481470@ziepe.ca>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar6gY9grmdMZcN/M@nvidia.com>

On Thu, Oct 01, 2026 at 11:03:15AM -0700, Nicolin Chen wrote:

> > So we can't issue ATC_INVs during suspend (the EP is already down), nor
> > during resume (the SMMU resumes *before* the EP is made active). The EP
> > can't use its ATC while suspended, and if it loses power/resets on the
> > way back to D0 (from D3cold, or D3hot with No_Soft_Reset=0), it comes 
> > back with an empty ATC.. same assumption the PCI reset path makes today
> > (pci_dev_reset_iommu_prepare()).
> 
> In that case, would the STOP flag be too late? It's only set in
> the middle of the SMMU suspend. So, an ATC command (via doamin
> invalidation) might be issued prior to the Point of Commitment,
> which will be timed out due to the unresponding EP?

How can you ever fix that?

How does power management really work, is it expected that the end
device is already quieted by its driver?

Could the first step in power management install a blocked STE? Then
we don't have to worry about ATC desync and that automatically stops
generating new ATC invalidations if we go and detact the domains too

Maybe I'm wondering if power management should involve the core code
so it detaches all the domains from the device, setups up blocking and
then the iommu itself could power ofF?

Jason
