Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6A371056
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310120; cv=none; b=RBolgsu2YXMRJAZX/bh8aQCn8dWkE1/F41wshjMW9KRD8rPc3j0frAtmQ/ISYcJDnafM87/88sYAiRZVJigZj1uGQYo/1uBWP/fNP2c+g9Z29mdqh5yOv7unt8n6JHn01g3nQTNjgNLK/vRfl3kcGYR/Vk84yGSENSfCA+70gIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310120; c=relaxed/simple;
	bh=EsLJvdLsMAdY3Oobb657DBhag9gfNQ+8zMcfmReVvxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3pDNySax0APJQ5oWEzUn3EPg5IpPt9wPb7BET5GXnClhIVsua/l2TuTEsoZTuyf0cMbaoi4sKdffhGniSJgn1ZnqJ2OWIx3BQ3SjchpKq4gVrBR/8OpWVxojmWcMAWbljdx/5LpyFgSyGvPVbvYruNi8qb3DtGuLl6VPOTu9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8VwwjCv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8VwwjCv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf22c18ad3so25ad.0
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780310119; x=1780914919; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oDUgrIyB02FM5mea3gf7dEX+Hdw7+v6D42bl2KCdIiE=;
        b=U8VwwjCv8iBedHG9zOXknOUgDRv3TGpk32nJhYihiKCa8TjsQo5tQAmglBBT4nww12
         TDS7g5tO3rNXotXr2y1HGXN2/mTxX2b+WHJW5dx+o5qCtyQb0oWLTu6f/1vS/16wL7oO
         9xptklTcVXT81U4bqmph8vLmNHQhfbbfyNwS9BZTGeXMF2RCtrWTyP1BQj6qmVLmxCAI
         fQHMNhyDHzwf4zs3mj5BKSy7pP/8muQtgPMtFLbH1/pPxiKLRAB8kWkI3yVRdzOCpGyP
         zc4hATKoqujc0UVNP4v9i8s+s4yknaiWzW6JsD7YMaM7KlbmlNkMlTZ/onxD0aIXM/Sa
         1J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780310119; x=1780914919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDUgrIyB02FM5mea3gf7dEX+Hdw7+v6D42bl2KCdIiE=;
        b=IY2sbRX35UeHmsOwkTvzmoCBnzphC+z+HRxf7VesCvkHtIWZGpviFn96XmUGw3sGpH
         mYLYo8f0UKpfvX8LkcqzIm2+juZQo4KpN7RNA3YwJZmQG2sQ6n5qsJVUrxVFAHU/pbin
         JHx8j8Fep0MoDzjhvzpu6Az4hv1Wquy2RVoWTuWbyqvoq2Ikp2QEYRNKum2pIPwb1X6b
         34fM763kB6rJ6inEbjloohjMEKoscoJSe+G6j49BXSvAbl2VbxN6/EPeK0qSIvimrqPa
         rg3qk0s2a2llI+3Ov/1P4WZcIj4tsQAV98i8vIuUPezOUab5zgJ/PrH6tiwV8fe7N7EX
         Eo/g==
X-Forwarded-Encrypted: i=1; AFNElJ9VXNqqNiiD7zsGhdNU/RRM9ChOEIPZKn8XquQ+XsEzK1yYuvfpOYM0GrYbaAisPQuii9p7gQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj989sW/GItPmrVNUZZT2iVW6SYQjsWWAI4+0E1T9oDDzQy+OU
	V9MLWu+uuOG54TGCYWAH9ZMy6fZKl0cDlGYPeVIrfxEBHyeUay/rz339ldta2tORxg==
X-Gm-Gg: Acq92OGpJZnxa20mVVwph19fV/lRN0Wh99hirmedQw+9gs5m0YjkFvThWbeAPntMDsL
	+Q9bBcQ27gf0lehxuF2h8ry6F0zCRI1/am5OxkdrWTAJvDFyoIjoO0mKaK0sOtuNIMi13iDEsaQ
	Atsa2uJwW3l1k785keuv5C8y76tJxcI2DlFiHSIEOA0JwSOAVtm9BXE3NcXMjyOS7RUO/Ur8AG+
	EhijSfbxZInr26XBcDYxgVAoe4dSHoRj5AA0/7h5N1uAPX/Zu7w3VYinYDK+5kycfi0mO7NIISn
	jr8YrZmmDCaRt6rBbyscub5Oe/kvt0f/UkimJajtd2MD65cbDosgxY46FkxYOGyKLK9zmMEFU8J
	PTE7839KOTqQb9zeMhenM9t7qTMvRG/oqRuHY9L96ZwKgJNIXANHpmHxDPt06wS4SX9+IaObTSJ
	63mtgAJjTpFGNGm3+BKkas2ALA00S3Tz6k4/nP6pOJ3xo5lKSf6rKztusxeTyAoQDjMc8gqV8=
X-Received: by 2002:a17:903:15c8:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2c07cb4cf8dmr4904775ad.17.1780310118403;
        Mon, 01 Jun 2026 03:35:18 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214affe29sm9720174b3a.3.2026.06.01.03.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:35:17 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:35:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 6/6] iommu/amd: Fail probe on ATS configuration failure
Message-ID: <ah1gXgPIdVXBzo_w@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-7-praan@google.com>
 <unqzyef2n26wdf6tmc6vvwvpsgv244uvz7cxji4scymqmoofyb@trkzr7ix5bog>
 <ah0kyi5asHpnrpgC@google.com>
 <drmnqcya6v6wtcazil4wojno2crp4obywudycl45uvqszp66ms@5t5uj2624dor>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <drmnqcya6v6wtcazil4wojno2crp4obywudycl45uvqszp66ms@5t5uj2624dor>

On Mon, Jun 01, 2026 at 08:17:23AM +0000, Ankit Soni wrote:
> 
> Hi Pranjal,
> 
> Plan looks good. One pushback: I don't think you need the
> amd_iommu_restore_msi_domain() helper.
> 
> If point 1 preserves rlookup_table on the PD_MODE_NONE and
> pci_prepare_ats() failure paths, dev->msi_domain pointing at
> iommu->ir_domain stays functional - irq_remapping_alloc() /
> __rlookup_amd_iommu() find the iommu and the chain works.
> So fixing rlookup makes the MSI assignment correct, 
> not dangling - no restore needed.

Ack. That makes sense—if we preserve the rlookup_table entry, the MSI
the MSI domain mapping remains functionally correct and the chain
stays intact. Thank you for clarifying that.

> 
> On splitting: While patches 1-5 are essentially settled. I'd lean 
> toward pulling AMD into a separate follow-up so the rest doesn't wait,
> but defer to Vasant/Suravee on that.

Ack. I agree with the suggestion to pull the AMD-specific work into a
separate follow-up series. 

> 
> +Vasant

Apologies for missing the CC! I thought I had Joerg's latest tree and
get_maintainers would automatically add Vasant.

Thanks,
Praan
