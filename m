Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74A212FB8
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068154; cv=none; b=jZvk86QIxHwlYOKZLNySEbsOKhbmmdCs9MjcXlbdTtrSzgPKmfLd/lKV4QEwG0tvK3XKLekmz1wlXti+nD97+RShDpPoBjaaM8493W709VJ4JVCFU/rWmns34y1g6opvPHHVkL44wXHm6PdoVdvAGqQtOA+5lpPP3yqGTHzVTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068154; c=relaxed/simple;
	bh=sefj6hxNE4DKzJ9Uo+g0WJ+GyLGTay+PVJVsLpQlNGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/6TsRNJLzDaQDZBpTVNbvMitvmKMKXE0RyKOPy6xHyYuGVMn849uadDPSCwUHZXGNQ+aIf3GGtXK6zFPwTAdHjsHZfCMyRuZwysAzekN+z3G0Y53e2AUh0l69wuQrPgb9k6+jjofiOIiCVTZ33OEq8p8GAknrMa2CUS9XhJW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=guyNccts; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guyNccts"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22117c396baso172405ad.1
        for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740068152; x=1740672952; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9z6CJ8GEmOUY+R90CcF3D8uqozLmZO9LjzSZXbDX8o=;
        b=guyNcctsrqox2KP8yrGpU+AcrrYAmBxK1eq11pMmVNK+7J/fB6PODgl695j61EHiiv
         1f6B/2WZg2TbE/RIzLo58A7D16sL3+Qkiwc6TLmK5gxRH/6iThWL5JAdUYB9kKhFL+8X
         qvs9qHHP84mzDnV0gcKLhV3ixGR2y4tHVj4z5L9cT1TQOdlU+Zp7RWKGlulgqwppgnI+
         iuDIVrViO9JCfMAIw3ZsJ7G3OAXtEpre7JxyvgZcsZ/QHftK+XUj5QiGU2sAHgR7su7C
         1zlyzuFOkxJSVt7meAAfGm0vBp4LdnUP5PuNNK20v1Pvon6k7YC54rpfPiwN3xhSh36H
         zJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068152; x=1740672952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9z6CJ8GEmOUY+R90CcF3D8uqozLmZO9LjzSZXbDX8o=;
        b=ZzJhCf1xy/ddu6XyzaroXjmwiBhioKDZ/zi8zGvDTH3LkXs9LQDv4wkfqvBzKqx1lc
         vAUTxkGfpPFPwIBo9qmSmYOQI4TvSJB+x+QoM+WQI61afse/O77zPuFLD1epnzA0NR0z
         NVW9QotsYsJHdODeUGPP9dNkSHyoucjWr70EVgaXM49jTGA/3PjrZvHMkoFZQo/FUL1e
         BcA9FkRbGuqKrQp/qapNfkr/T7S1FsxMyIJ7FHfnBRu4I818SMLwabCXI66N5qet+V2Y
         x/Lzi5oOEGu/YdOPUn6kehlqRMrlr49Ln/G0R//AtfdCBTZ+HCSNIccgYm0DscSu9dF8
         jX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaTx9fPVQIbmM01gW8eqjkurByrZ6+X+qKynbEBfickmm0hO1tGxVdMYbUpXMM75wISqsV8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywtffv14VKjD8ENmZQl3QL1bUKCyBMWhVuXEvGFgbxYJzoZre1n
	Q+Du1MvscF7cjmyXteoxDLYVe9cPt1dEp6aXqPAIx8XhUSIJTgMAuN7ulUUk5A==
X-Gm-Gg: ASbGnctLvxYmjUPP4gyfZroAA87fZkBm8N5KFCLpT6WQwHIAowS16ETSl+PWxBtRNMM
	gUmJRlqIuobizYZUnR0gcnUYMWOqVDHNBFfHBQ9JR7vyrjIrd1WLL/bNSE/kgaM/Cyzdj4A9n5G
	lUZaJGu3jd8A9DVXQupKDUgN57RLG3uQElNOSVuMMmlTEzuZ/2X7TCdyHqOUXLLPa6UQuclp4qm
	ZIE/yKTYmHUIPPgNa3WD4J21KSUSM1bRiyEHivLGtdncSKoAGrkKEgRNPQO9RqYe4rxJ5MM3yKs
	3YeHmrTDvBpH1TqGPu3sLr5NgMqNJ4cL0mrfW/doRe5jDIcNwuZ4
X-Google-Smtp-Source: AGHT+IEeeNO5YXG4GrTFzHJDa5KXpncdRPcsXRbYIZYGBm4w3MV78t3++PWrZwNmDnY5dth9MgRnnA==
X-Received: by 2002:a17:902:dacf:b0:21f:3e29:9cd4 with SMTP id d9443c01a7336-2218debe8bamr3119545ad.20.1740068151245;
        Thu, 20 Feb 2025 08:15:51 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc7e9325fesm8522382a91.46.2025.02.20.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:15:50 -0800 (PST)
Date: Thu, 20 Feb 2025 16:15:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
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
Message-ID: <Z7dVLNLhP7VfZ-Ph@google.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
 <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z7TOq-gIGPY_ztW7@google.com>
 <Z7TXQ9EdyvHp/lmD@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7TXQ9EdyvHp/lmD@nvidia.com>

On Tue, Feb 18, 2025 at 10:53:55AM -0800, Nicolin Chen wrote:
> > > Is MEV available only in nested mode? Otherwise it perhaps makes
> > > sense to turn it on in all configurations in IOMMUFD paths...
> > 
> > I think the arm-smmu-v3's iommufd implementation only supports nested
> > which could be the reason.
> 
> I guess what Kevin says is that non-nested STE should set the MEV
> as well, e.g. BYPASS and ABORT, and perhaps stage-1-only case too
> where the attaching domain = UNMANAGED.
> 

Ohh okay, got it. Thanks!

Praan
