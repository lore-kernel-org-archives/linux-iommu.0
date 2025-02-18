Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02A28137F
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902650; cv=none; b=PDJitv52PmzQm1KMO6LP5sdHWQBBh0CSQaZLpaE7G1bs6MerzajeYIM2P01Z3lgdJQhK5teMy4pba2v/ekptSYaB95MmXtdoe92m9cvRTsZWBuZWgg0N0OrssednrOG2QoQ1p0qTb6YGEN3wZCBnsXIcwLC0DNGYo+vJ1aPRlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902650; c=relaxed/simple;
	bh=BOUyx5EsWWjCZqwoILlVSGflf8blEnkgIikzItCUqP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1GLD6yByPAJLDNi44sa/5EkTVQcXJ2auP4cFR0PzE6BFjALIzsRh41RiMfZKs5gt0/z3wsDcoC5s69bot9EWoh5p8fZVXtGgm/w4Rl1Hp6aanaOTy14hkfAeiNR06s8e+sbQmIl3b+5DzmULmy7MknCoTbCXDMzhJ3EaYCyWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pneuUPyQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pneuUPyQ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220e0575f5bso490485ad.0
        for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 10:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902647; x=1740507447; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M89M9SRzWTrfxkPQChi6cYghdfRxV0Kb26Fn5pPvW98=;
        b=pneuUPyQCty5bxfduXqlUuf8qHqrBMB0cAUeHAweZwgeLumARGcJD5k+pH9+XNp5s2
         RFrW42fe87mPM+pzqEFM65CBfFXPnE2ygC1IKUsNnp5CDyVW0JqZKmKxuvcAZHY4oPoh
         FnRl5CLXihIn8Itjtq8ilKfPWrtbQzGntAzJ0+MZdInsVO56KCXQ1d1FQXHkr/oYnqts
         1R7w6IcNK4ON4UNGmL8pZvfye/VbufX7rHp25JF6MWHolBG0kjP/CyHJrv+JuDFOB1f9
         MvDxpQoq1DGxq1V138GSBtVa/9FIkyXqmSgKLjSkDmms7U/SpLWbdSRpCtmhWuEI7PGg
         ePyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902647; x=1740507447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M89M9SRzWTrfxkPQChi6cYghdfRxV0Kb26Fn5pPvW98=;
        b=OMNXe2AJxUcEmSAR0qDw3a8/F+nSv2OplYc3slxtBHfCbL9BptDo3TNouetiAC+NYF
         yQkXDakH1x5w98fD8NptYocaNnGdQn8h8lwSuBEMnJZTJswWsGb4iwZkYiS0hcyqAmLE
         Te1WOeemjgaKxEKYQR4w109DQ6b4EOUGWDX3jizaLEdMWy9bDiTF5ohmNv9l9nW63D6t
         SyGdTtG1AGsPtvK12NySiy6izAMPS8/C030iiZNwhx+zF7Bt/fy3ue+nsF8gLWR/V9Vm
         uoKeHaZXwafRWNKxWGtS4CBae1O1Galz2GALAzKPaOU3DwSYltiRHwtHkOBahKmEWOXB
         yrcA==
X-Forwarded-Encrypted: i=1; AJvYcCXx5xkcnNzh1anVvaMVLRIvzLJWssHptghUPNTU0yk0oP07TFPAtN8pYnN9ol1YjGSpUUMYhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKbvr9EdgEu6f3e/P/aNWltUKvbZdiY9MXdPzxQhYKjLMXqTD8
	FXnVW38EcXVpckBxfgf4OtNJtE1APudTJMYPqoWCv6TxqiJAaZB+cYzR/+zfVQ==
X-Gm-Gg: ASbGncvWlv3aS/dSxY/P4xwIns1gTuLugc+eEOekkKGLtBDEVpMoeUekTxKfs18GV7P
	VKI/drDJ48/mcLZTCgh2ZD87sBF3bP5eTpZxUk7zXKMhE/2x72JbhSegW6fwVFqNf4LuSTDYhRO
	OlMuOM8bJM1UJ6xGBalYR3nVwzhc/Lb75V+q4kQBB9Wh/mlMyRHMyhPyKFz3ILL+6QlQucYYegL
	VWUcCh6H7R9YCD1UFUUoikEOChRDnBz5mEeAD2K1RLzjDIO9K1VnBTyiYg6MjrrqvcpDp1LNc/l
	ZI/EFqNm+mfzvIrSwQVxGA4duaLWkvpc4SJMYwVcL4yuxeldy740
X-Google-Smtp-Source: AGHT+IFkiHL5TTpaBclB/MgmM3kcQbDHYVWCGmPRDpeRclWjC4Poa8aWW8CJbN/ySGXple0OccOeRQ==
X-Received: by 2002:a17:902:fc4e:b0:216:48d4:b3a8 with SMTP id d9443c01a7336-22104c939afmr7012905ad.16.1739902646969;
        Tue, 18 Feb 2025 10:17:26 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55960ecsm91516115ad.253.2025.02.18.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:17:26 -0800 (PST)
Date: Tue, 18 Feb 2025 18:17:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z7TOq-gIGPY_ztW7@google.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
 <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Feb 18, 2025 at 05:24:08AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, January 25, 2025 8:31 AM
> > 
> > There is a DoS concern on the shared hardware event queue among devices
> > passed through to VMs, that too many translation failures that belong to
> > VMs could overflow the shared hardware event queue if those VMs or their
> > VMMs don't handle/recover the devices properly.
> 
> This statement is not specific to the nested configuration.
> 
> > 
> > The MEV bit in the STE allows to configure the SMMU HW to merge similar
> > event records, though there is no guarantee. Set it in a nested STE for
> > DoS mitigations.
> 
> Is MEV available only in nested mode? Otherwise it perhaps makes
> sense to turn it on in all configurations in IOMMUFD paths...

MEV is available at all times (if an implemented by the HW) and doesn't
depend on the nested mode. As per the Arm SMMUv3 spec (section 3.5.5):

Events can be merged where all of the following conditions are upheld:
 - The event types and all fields are identical, except fields explicitly
indicated in section 7.3 Event records.

 - If present, the Stall field is 0. Stall fault records are not merged.

I'm not sure to what extent, but I think *trying* to merge similar event
should reduce some chances of overflowing the hw eventq.

> Is MEV available only in nested mode? Otherwise it perhaps makes
> sense to turn it on in all configurations in IOMMUFD paths...

I think the arm-smmu-v3's iommufd implementation only supports nested
which could be the reason.

Thanks,
Praan
