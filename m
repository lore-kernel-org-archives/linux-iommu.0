Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334302;
	b=BOTI6M0+9xC5vIlSOsT2AydHcO17+PVvKHQH1RAYLs1yniZYSbjIi2ET0icPDPj90pAA
	 /svRq4uQVWdvp4OZleLFldGWrzBHWWcr8qwRoOkWVlCWT4WR8Ak7rJbxop82ZViJMV4gt
	 GwdmdPmz+rgFoD/S0H3xqwbWnKrIvrhn5pp2aDfwUipB+A5uYWtHQ8cCt2W7j0XizVz9J
	 Cbewq0qVCZuv1UAWFtjFzJXgQUEUoMVx2JAsEtDykGltE1z+iLqLpyg/2C2XsYiPabXtD
	 q5acBPG/N9ZJPdoaN0dSAwNrCxP0kPergiaTabagr514dSOLx4iomwXdz5rR6ZMhMDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334302;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6UWz2r4tRe+d5sBTZILDgcPvXY2QrlO5HEjGBHt0YeY=;
	b=eC0dQ7DOpAp3E6y3hMMZlRq9qPjLiY30H+L2BxIBK6b99lHAOWXMefpva1OL/3WJdcrT
	 m8CAZS622/pGyAaU9+vvuvXUoNZ1WgsQyeQ88IO9Kleq0oxS5c8gPR3qSYwe2qYi1VACc
	 +dnLq+NWXyy3pcceKUoplvLKoKQtoF+lO4lPbYVGoTiKi1lL4r41Oh9pPDyheu2Kkf+e5
	 oAa9CB3i9hdf1ocT1+pZ5begbqmgXTFMb+G85WFxL4lDlGsLIBBddeOWUHU+4K+iG8g7Y
	 JJ6FPrnMN5sCVHdHxS9Crh/7bBl7mLk20u+nsbF3K7bhomtZsaC2cb9AeHAMqkjMw8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SE+99AQJ;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACD606A31A
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 04:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDACD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SE+99AQJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793334302; x=1824870302;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JN7BobmyqJQz8QBWSFXXVHvnF+XO9EeeYbr8xgk6MLM=;
  b=SE+99AQJL6C2dJ3d6bU2xZ4Z67GNzPqKZjkcH32bdfyKQqS7NGWSApjd
   Y76O85cXV/jGJjckMD/7D4H0RWgPmM62o5ytFGkHVKsUHixPNVeiUHPAK
   EaJ11wAiaX7ji4PrOHBiJ4SKhMLD1kmjd/WrtnN0QoAsRoFlKwcU1HGsZ
   nkFvZIK7HznrWv2I76MIDAlIlu1HtVrCV7C3QwllfGtViMSGKlqWnxjb1
   oubkCSNYJq92gI2H+T1TKIG8jwB9QWnXgi95klkLVEct9V//zIhJqeT2n
   +T1Z4Og9dlwFw58VL6aJ/lnZwStxvK0mSh+lKbRr/UDw2iQ8UhP5c2LSW
   w==;
X-CSE-ConnectionGUID: 569S+tbQRCC/EWA8mwBptw==
X-CSE-MsgGUID: 1Afcws7rR1OukrKhJUJb/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2000147"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2000147"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 21:25:01 -0700
X-CSE-ConnectionGUID: Qtddq/EBT++4lUoxFz+C5w==
X-CSE-MsgGUID: +WO64qkMRV+E/MtMOoE/KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5735215"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 21:24:56 -0700
Message-ID: <3be0b56c-4689-46cb-b6e4-b1ae43be5b08@linux.intel.com>
Date: Fri, 30 Oct 2026 12:24:54 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Pranjal Shrivastava <praan@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma
 <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 04/18] iommu: Implement IOMMU domain preservation
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-5-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-5-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> Add IOMMU domain ops that can be implemented by the IOMMU drivers if
> they support IOMMU domain preservation across liveupdate. The new IOMMU
> domain preserve, unpreserve and restore APIs call these ops to perform
> respective live update operations.
> 
> Reviewed-by: Pranjal Shrivastava<praan@google.com>
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/liveupdate.c       | 119 +++++++++++++++++++++++++++++++
>   include/linux/iommu-liveupdate.h |  11 +++
>   include/linux/iommu.h            |   5 ++
>   3 files changed, 135 insertions(+)

This patch looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
