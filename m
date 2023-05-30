Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3F370
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 00:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685405809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBl3q2i812Jlu/HY8zePZKnZZJeg4miQ7XeIUUOuIUs=;
	b=EC8IjAlaEJeGBXv9msEe2PdkvOHjVXRikyqJlItGhZoe36YjqmxzdlK8Xusjb+bAPiqU1d
	Pd9R5CwwQwv14isZMokhEHJtOQjvrhAPxvS1sHuCbIeSEv2NQf3GNmqS4NICocYOWj0MWH
	gtau7H3FlWceDAlkbuGcACATVJVvFhI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-XCPfqzsBPIK4knEzwBELSA-1; Mon, 29 May 2023 20:16:48 -0400
X-MC-Unique: XCPfqzsBPIK4knEzwBELSA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33b59d59193so20320095ab.0
        for <iommu@lists.linux.dev>; Mon, 29 May 2023 17:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685405807; x=1687997807;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBl3q2i812Jlu/HY8zePZKnZZJeg4miQ7XeIUUOuIUs=;
        b=iFjwVIpHKMfXiGOskeArqWTcFca/AyHxlrB/jPcj3CRQLnmj88wlxfnFE4ICOnkhv9
         BPFMhzDK2q3vh5wdaUcNR+jN3KGoHBWx4urYqbu7VdNUbJGlor2IJLl6iXPZevdXo6Sy
         9owq0UVRn2zJHWH35kLLs/8vY4uCjVnArHM6n2/43OLLPk3Af56h2LI3fdA41XeQp2jH
         35orLJbWamSYiwHRahyU8ByHtIuNIcVfsnqVEMuUfosRg4/g9q985wxYCyajwStai3W9
         wTfwIN/LZaauLfWXqoIfyZiBYntzwgdO1rfsLPhSQuL0EAWrcRnLp3NZa0JMPxnGld0B
         YmPw==
X-Gm-Message-State: AC+VfDy2SmWPFg9FvE8P4Mg0CiZVXmPgIUoaqXOPpXP/OWUyiN0SWzTz
	iXU+kRntyiF4pXXK8kJvztgyyqyWhHBXOktw51F3ejHg+wJqUYa/TTJ2mpdv20rCfxMFExzjDvv
	nHd6PdVK6T2OwpnQ=
X-Received: by 2002:a92:dcc1:0:b0:328:8770:b9c2 with SMTP id b1-20020a92dcc1000000b003288770b9c2mr507365ilr.14.1685405807098;
        Mon, 29 May 2023 17:16:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73yMhHh+AVUWd+tWnEm39ZtbwzqfO2AHakkj3n4fptb2pthTIWuj5Tj1tTy9hAry5+QAej4w==
X-Received: by 2002:a92:dcc1:0:b0:328:8770:b9c2 with SMTP id b1-20020a92dcc1000000b003288770b9c2mr507347ilr.14.1685405806881;
        Mon, 29 May 2023 17:16:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d6-20020a926806000000b003248469e5easm590655ilc.43.2023.05.29.17.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 17:16:46 -0700 (PDT)
Date: Mon, 29 May 2023 18:16:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com"
 <lulu@redhat.com>, "suravee.suthikulpanit@amd.com"
 <suravee.suthikulpanit@amd.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 00/10] Add Intel VT-d nested translation
Message-ID: <20230529181644.3a6a5c7b.alex.williamson@redhat.com>
In-Reply-To: <ZHTyNgnjj/bOkIgi@nvidia.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
	<BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
	<ZHTyNgnjj/bOkIgi@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 May 2023 15:43:02 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 24, 2023 at 08:59:43AM +0000, Tian, Kevin wrote:
> 
> > At least this looks a reasonable tradeoff to some proprietary VMMs
> > which never adds RO mappings in stage-2 today.  
> 
> What is the reason for the RO anyhow?
> 
> Would it be so bad if it was DMA mapped as RW due to the errata?

What if it's the zero page?  Thanks,

Alex

