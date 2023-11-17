Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110CB31A89
	for <iommu@lists.linux.dev>; Fri, 17 Nov 2023 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iqaLUxxM"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77a277eb084so117644885a.2
        for <iommu@lists.linux.dev>; Fri, 17 Nov 2023 05:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700226479; x=1700831279; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYJC7txQg+XVy3povoIneigNeaYf7XjMoOZStClkpv8=;
        b=iqaLUxxMMCE3v6HhcdShX197TkMLOevaAAOrqH3+SD5VxfJLVdnoV6Il0r1WpYijs0
         BZu12egsEOHuLEU39GrE/KYU2sjL6pSs/w1g0xZvaTTkijJXjjit1DEyH7AykyCdQaKF
         HdX9vPZYgD1AKFoUBzrN3yFxl+HoFdZujESqbiCFMzkVibIbZyT0nM6DqKlAWFRQ9yZL
         krmT+AjBHX3iwjgVXdDoUp57BbFwAJU2BCTAgbdVeROMTRxYs4n3QxXRdXZWgvtdZogU
         DT7VDIjOFF4liwxu/DM4ZXG54MfFmqiqWB0393h6gncGXlHXVbnqBe3CNmcbn384MA/I
         uLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700226479; x=1700831279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYJC7txQg+XVy3povoIneigNeaYf7XjMoOZStClkpv8=;
        b=wND2G/Kua5i1jns0zgUjnKNpmnegex5M/Yz8SFcSJXLr8PwdppUnfyJ4+BQQUOZbIw
         fOAxyC8zROLDVmnxImYSOyQoqkLV/+dtzBqdibAP18cTdlQpHwPGYV3MKKzwZYGYgwOu
         pPhWPTNGyiZxwtKSz7dpQhgeYHTp0ldM0zvMxi1cisY2oXP+JSbKndF4GV7wyAVRQPAj
         Ao5MNNlsg33pnuISApoSUbo+XC3eofWlPYAxGg0vajq1+TkXFLSNvw3tAOQcTEdrvXBG
         4FdgQQvQQ0YzEVxfKkl4+5wni2e6nmHmABS//hb1RQnrEqtjgAmVYpCrKkV4rXvGA3zB
         N39g==
X-Gm-Message-State: AOJu0YxwfyiHfoniE9CDuPGH3Qn58i2Uwp2nQj8usLnk3+qgh9ekaIV1
	Rh+7Ql/kTk1ix2Z/wQZCUeM/zg==
X-Google-Smtp-Source: AGHT+IHGV9/z04xgmmPRcNGEMI55AbHf/lPg7kWBwBZVnpSAw4YdYeqeoXjjPc5CcSIbzcPMeEbOXQ==
X-Received: by 2002:a05:620a:4104:b0:77a:5493:8a3 with SMTP id j4-20020a05620a410400b0077a549308a3mr14826885qko.11.1700226478437;
        Fri, 17 Nov 2023 05:07:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id az44-20020a05620a172c00b00777611164c5sm577475qkb.106.2023.11.17.05.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 05:07:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r3yZg-0001hp-Th;
	Fri, 17 Nov 2023 09:07:56 -0400
Date: Fri, 17 Nov 2023 09:07:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iommu/vt-d: Introduce dev_to_iommu()
Message-ID: <20231117130756.GA6501@ziepe.ca>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276CF0833BF362C1BE5F2268CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <053e89dd-8de9-43f3-8530-1f65181efd46@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053e89dd-8de9-43f3-8530-1f65181efd46@linux.intel.com>

On Thu, Nov 16, 2023 at 11:23:56AM +0800, Baolu Lu wrote:
> On 11/16/23 11:19 AM, Tian, Kevin wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Thursday, November 16, 2023 9:51 AM
> > > 
> > > +static inline struct intel_iommu *dev_to_iommu(struct device *dev)
> > > +{
> > > +	/*
> > > +	 * Assume that valid per-device iommu structure must be installed
> > > +	 * if iommu_probe_device() has succeeded. This helper could only
> > > +	 * be used after device is probed.
> > > +	 */
> > > +	return ((struct device_domain_info *)dev_iommu_priv_get(dev))-
> > > > iommu;
> > > +}
> > 
> > Not sure whether this helper is useful. This is only used by 2 out of 5
> > post-probe users. Probably just open-coding in all 5 places is clearer.
> 
> I thought it should get more users in the future development.

The pattern in the SMMUv2 driver is like

  struct device_domain_info *info = dev_iommu_priv_get(dev);
  struct intel_iommu *iommu = info->iommu;

Which really isn't worth the helper, unless you have lots of caes
where info isn't needed at all?

Jason
