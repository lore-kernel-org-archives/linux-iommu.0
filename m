Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F78179211
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765996; cv=none; b=MTu5pJAOBgMQsCDzHbsfFGXXbuMinQYgqvIVuZD0WdxkjEwa7Q8qsFBwBou3KX+pUMR8F9MTOV4wzu7vDWf+3D24hlwEB5mZDaaEecLoSxbFBTAqyKoGWv6gczs0H7mnoExGyJ+rouUYFgEfnF0wnlRltnFpIq/H9ZPaRFD5IUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765996; c=relaxed/simple;
	bh=nkV9cGAED/z/VIex+b/PSuJe4lylFvXK/ooyXd9u+WY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9d17otpR01YHqVxUVU8O5aCp34E0jK6OVKmoeb+QkkISAEIzJUemp2O9RePiScHcCP3JIHBE913m0YaW9mHIYLSnqBP3roEQ87e++bJ+0k9JiXTbINobAnqa2hbaFkFuCrWt18QoxJqXoDzlOsmrb/0LCZWfO309NQmxCsl82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXb7xDRX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXb7xDRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712765994; x=1744301994;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nkV9cGAED/z/VIex+b/PSuJe4lylFvXK/ooyXd9u+WY=;
  b=lXb7xDRX9XCV574GXJkj2KTBVAz4C0Zl67gg+VDMT9bA7WNDxBe0MmfP
   Ixv1T7gfrhHbHGX+aOQ5AAzw4CBYOq+PHjVgE9h2d4CFn0CT5by+N2Bxj
   2RYkkRRaJ3+TWsGenz0ZZKICFPh60I62x6Mwu/OhBoFCXWSV6HjgBmWxH
   ZGRv1deGvE1nkH5HWPh6ydEwI9xT3PrsyVcuXQaltcyGLU3nxtSqdw6+F
   aNZr1m+YtmPffZcJnVOpvc38f2NraETNDFblltAYM3yc58iq9k31TysA3
   SybiHZMb6nYc0Xy2tUK9LsWBcrCslBFVcQyCUHfWX9p9ch3djcTxiOpxs
   w==;
X-CSE-ConnectionGUID: /JTHzZ5hSWKV9C4jmYDkOg==
X-CSE-MsgGUID: 7nxvpUfoQdCgG6bOXstI+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8316626"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8316626"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 09:15:26 -0700
X-CSE-ConnectionGUID: bYm3/WcVRy6UqtcJM8vh6g==
X-CSE-MsgGUID: lJv4/ogSSgGrN2eFG8qM4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20570377"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 09:15:25 -0700
Date: Wed, 10 Apr 2024 09:19:55 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Message-ID: <20240410091955.5c00e411@jacob-builder>
In-Reply-To: <BN9PR11MB52763F42ED6719E6D03D0D308C062@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
	<20240407144232.190355-2-baolu.lu@linux.intel.com>
	<20240408140329.6290377f@jacob-builder>
	<aff42b8f-b757-4422-9ebe-741a4b894b6c@linux.intel.com>
	<20240409103146.0d155e45@jacob-builder>
	<BN9PR11MB52763F42ED6719E6D03D0D308C062@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Kevin,

On Wed, 10 Apr 2024 00:32:06 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Wednesday, April 10, 2024 1:32 AM
> > 
> > If the guest uses SL page tables in vIOMMU, we don;t expose ATS to the
> > guest. So ATS is not relevant here, does't matter map or unmap.
> >   
> 
> ATS is orthogonal to SL vs. FL. Where is this restriction coming from?
For practical purposes, what would be the usage to have SL in the guest and
ATS enabled. i.e. shadowing SL but directly expose ATS? 

Thanks,

Jacob
