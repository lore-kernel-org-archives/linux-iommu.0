Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239949E12F
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997163; cv=none; b=WdBOmQ/F3TxiHcg/zW1F07gi4BeLocWss/9ndI3EQGHRPiumonyu1rQ+8+Dt5pxRKJU+U12iP7ADxiAeiJRmN/inslZIiiTzMx1DkyCMCjc/ovGKaipg91+cMlGWLXq4R+7/2svP2u21jpVMcdQa6NODnkKwdFP4O4j70KhEqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997163; c=relaxed/simple;
	bh=jI7O6dwFsIzcl16MuxgQK+8Hj3EPC7adm8Q/IYAxJFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT96eLGKqUlgaWEtBAL8mAEjq3xW2LXONBSxMK4EQPxN5fmPkbyXGkiC/nBcDpXSJYDPnoqxg5BslQCWA9D3UzZYTFWjj4fU2Fi8LvzD1hHLT0mI5a581SJvrpFU5d8Lasqy/g68HrTbU3zPwbrca+Mtsld6NLMtedaVisLy0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R8L6iB+h; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R8L6iB+h"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5059f9so1599470e0c.2
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789997160; x=1790601960; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jdn4c9lGyFJE/+rps4rYYBXSqoAaBa5j8WwP9obCXz4=;
        b=R8L6iB+hk3T96cTZBwalHt/o+3wkr7ww+6BQPeEvBsuN4m0im/FHZAamz3sR2STAFi
         q76HrjAlIssFH0wsBwZYd4CLDKRdzWFNR5SwT+6sgIlZAxeusVOgpGFcdZRr+eL4sA7w
         9pi6h66A4bszbFVZYcPY652B1LODNvUxUI2lHYZiizx/NvSaN4iWZrUR+ENjdwvgbhy0
         rje9DMBQ9XTE3CZVNThGPUSlLxNeZek3aRXOiXYGXSBTGhFZigWj1lv+Y2wF95MNqO6L
         sSScN318idD6otuQBNCjhX6SVFEiLEiKixh5tNySlhx3r31OF0YiHs4EWnkkfxbi+f0b
         AsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997160; x=1790601960;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jdn4c9lGyFJE/+rps4rYYBXSqoAaBa5j8WwP9obCXz4=;
        b=o9sE3xB7vAmcG6CgQinj9velQyK25Hge+NdLcZ9/vh66khwSZIFtqdPkFUYwyhbsNu
         6UKOFjZtzjn9RMJduzyFa46IjwzbeB2BpCeOP+sTbws2FTcxkRqnfO3y34RyyFArMOyK
         jDA1zKX+YKUqJuyE0XOQOxba8YzvgT6togBXtOi0WchuhNKEvA6MPfIQfuOZIEtt+975
         iwY38SQoqL0lHuhSU5uaCURiczYLzUiuVSiQ/LO8tdAIioXjQ9Iyyh3WsyrMi8NP/bE1
         WEMhDa4fRHcCfMIU6F6NBd2MwLUhWZXOQqDT4ERfGlY295oFhstYVYNO6v662sHc/8W+
         pRLg==
X-Forwarded-Encrypted: i=1; AKwUvBzQAE/0PXyBTpc1JhrdDbKqDrxYBNmWIWm6rgCfxgQt81MdyrmQ+vKrhM66Tf5Tz3Qpxa/PIQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n2KO43+2h39YZ9Mu7s2cXt5YcsD6iVfh0xpDRWGlDxylBVyAOu
	73gTtC7cU5t8+/gNLUV1jJdvKkYMBg74h6vukRKaWEXaTc/DHZSRapCAwLHppmtxDe4=
X-Gm-Gg: AYBFou36rh1YUJvW8xgOa77ODoUxJQEXf3hFisvEIoUqInHbU8QBPRcYRKxyfPGeQaQ
	2I0sHks/T/U+TnP9h9bdWNJQXygNYAcpQ1AtBbLylHDWxhCIAsYtcGrNlIQpeuZcuf/LOxV/qPs
	3Mj8AEFbS0b/swFH1fv5BcaycZ36A0Pee+zcgTLacAebfyG+udOOeRl+RWSU0Z6Nsff/EbiwBC5
	Q4ih5fDYjhV/50Uv4nbGVj89yrcIaVbFO64e3MYTe5cpQl7gIn8hkFvV/HqA8xuQ6Wqdt3xn7i5
	btwQiZsNx4AJPNubBcJByh+RbKFCJNCI1ohh85vonfOIezvoITdtcnjV82ifEc5htofJ+7rAP9d
	lA4t6mEtGCdLn4zMvQu5y/MIUsqFZSnFr2Z4AxaOkRAW2ylcCd+TIzx5agFYFzm02IxYrVLNTlR
	9eNqn1Mw2FVV2vR8eiGX8NdW30xJ7H50yqRbtN4UC88x1eCY3F5Dt5aif/8a4iarOm4+/ubeR6D
	IGkRY4A8ok7HcT7gTIf7OerrQxmi6Uxn81LbgVyPCgiZ4/yfHRAcsbO
X-Received: by 2002:a05:6122:209e:b0:5c9:a491:641a with SMTP id 71dfb90a1353d-5c9b8a6c1afmr4625797e0c.4.1789997160437;
        Mon, 21 Sep 2026 06:26:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a60f21sm67324286d6.19.2026.09.21.06.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:25:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x8e1v-00000006Knm-1R2E;
	Mon, 21 Sep 2026 10:25:59 -0300
Date: Mon, 21 Sep 2026 10:25:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260921132559.GQ11599@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <20260918121500.GV13683@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918121500.GV13683@unreal>

On Fri, Sep 18, 2026 at 03:15:00PM +0300, Leon Romanovsky wrote:
> > That is, a flag to tell the topology check that some transactions
> > *will* take the host-bridge path due to IOVA being used, and that the
> > computations including pci_p2pdma_distance() need to check whether that
> > is possible (checking whitelist etc.) and return the corresponding
> > THRU_HOST_BRIDGE mapping type. Translated transactions taking a short-
> > cut using the bus-address would then be hidden from the driver.
> 
> The word *will* puzzles me. As I understand it, if your device has ATS
> enabled all the time, it should always get THRU_HOST_BRIDGE.

The P2P subsystem currently does not understand ATS, it assumes the
device will use untranslated requests and makes the routing
calculation accordingly.

If the device knows it will use ATS it should ask P2P for an ATS path,
and P2P should only return THRU_HOST_BRIDGE or failure.

The purpose of involving the P2P subsystem is to verify that the ACS
flags for the ATS translated path are going to work. There are many ACS
configurations where the fabric will hang :(

For something like mlx5 it is ideal if P2P chooses between ATS or !ATS
based on what provides an optimal transfer. eg there is usually no
reason to use ATS to access system memory for streaming (ie non cache
hitting) transfers.

Jason
