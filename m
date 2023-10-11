Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B311EA8B
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Bgt4lueu"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d8195078f69so7544735276.3
        for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697039077; x=1697643877; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WoB38qVrfy0Z5NrFm6D5FEtkeSsKsFCNUumBknFNT7k=;
        b=Bgt4lueuatD/0u4OxfATztjBv4oBcrFLskHTyzZJoMIaaSgvGpJJHxu6q5Ss8o2002
         w3ZDXs74w85b07Azcb48OijG/DBxhT6dPCG7jgl+m6pcLzbImyQQk9Irfc+8Y2961r0O
         lRddyX9ZWd8QN9+UYCsvjl1cm5ykbV+9VXRi3GVYNOIgwX7xDx6IMVLXQkyI5c7VYvST
         rTcJZypaZeFPIqH86E/+lmBCTY2AfiWfzRjRYHubjQYXAEvU385goM+6Tc/IdfmgE/OB
         CzacNiIvXYkRgZU2bb4bC/hpCJL4bp+zK0vBYW8S50/Nez94GQahrE5MCk+tH85D12Vv
         Bniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039077; x=1697643877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoB38qVrfy0Z5NrFm6D5FEtkeSsKsFCNUumBknFNT7k=;
        b=lNh9OYEBQztEDutwxmMi9per+Np50ynK46Hgu1xJFBOHGTDW8xYzaBRmflRv1HZbSV
         zFHN5TS1kHg+0NeooxPPvaiH65vTsMz7O/ITnj3W5DgDFlg2ItFQb2JERmWwATnbthY1
         5PlHmZdHN8fpZ0PAiZftXDUciPnLjCa01wGMwk/6/qXEMmVIERUkHJCJLiCfuMPUGV5h
         RGXTk/UVDzwiQS9EIYSauhrnWXkVW/QeQIJ05P4jjgBAWJdYEQKscMHrhbTcJumlMtGK
         b9qf+/s75iXhHK2kQ1gplyP3q/QJn2TPeQMWdXRDCPnCYXyym/RlOf0bDQElc6gg+8co
         f+pA==
X-Gm-Message-State: AOJu0Yz1PpAdlLh9Sat5vM7H2zk40I+OfNfh6sWnwJJENUwfnyvKfK4n
	xB8XpNhcj30OaagUR+RU1LOoXg==
X-Google-Smtp-Source: AGHT+IGPRIevfR60iyGshI42VdKzgNUrCL0njQ43RhfaylkSDbzn1Q4Db90GZVIb3bqd0dkp+tUWcQ==
X-Received: by 2002:a05:6902:202:b0:d91:fdb:afd4 with SMTP id j2-20020a056902020200b00d910fdbafd4mr18990169ybs.16.1697039077048;
        Wed, 11 Oct 2023 08:44:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id x8-20020a0ce0c8000000b00658266be23fsm5775096qvk.41.2023.10.11.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:44:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qqbNz-000hH9-N4;
	Wed, 11 Oct 2023 12:44:35 -0300
Date: Wed, 11 Oct 2023 12:44:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [v6 PATCH 2/5] iommu: Add mm_get_enqcmd_pasid() helper function
Message-ID: <20231011154435.GE55194@ziepe.ca>
References: <20231011065132.102676-1-tina.zhang@intel.com>
 <20231011065132.102676-3-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011065132.102676-3-tina.zhang@intel.com>

On Wed, Oct 11, 2023 at 02:51:29PM +0800, Tina Zhang wrote:
> mm_get_enqcmd_pasid() is for getting enqcmd pasid value.
> 
> The motivation is to replace mm->pasid with an iommu private data
> structure that is introduced in a later patch.

When you do v7 how about:

===

mm_get_enqcmd_pasid() should be used by architecture code and closely
related to learn the PASID value that the x86 ENQCMD operation should
use for the mm.

For the moment SMMUv3 uses this without any connection to ENQCMD, it
will be cleaned up similar to how the prior patch made VT-d use the
PASID argument of set_dev_pasid().

The motivation is to replace mm->pasid with an iommu private data
structure that is introduced in a later patch.

===

Jason
