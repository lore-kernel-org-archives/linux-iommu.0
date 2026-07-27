Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0A393DDB
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120801; cv=none; b=BPJFEQ1vL78WvyY0LFbAptxBkpI/AObR8g2xFjUa69/jpw+Yj8QgLhde8HMFu/aYAq1yBV5UG+3u0r9OLxJoUYyJNhL3xoAw6M31WqAEaxf0PATPfL8gt5mWrsy7/5XNOIppJH2bglETGw5ka4Ymb+OD7m7+gh6OCO+0ugRhz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120801; c=relaxed/simple;
	bh=8EdsphQ5OQ2t2aNq2urG7f9+JHxltMx8yHXvmDTCXw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRAPjVmK0xWVA0Vhj19qL5pU/JBMdojosqSRdUWZ9JVDoN8e2Tv65EORn1wTPt6OQAS/eDLvusfnAdsQuCCvzoagd9Zc+CoYkyknqlgs0rwmaLardcgGN21aD01k58oTtkkBx2FcD8I2rn4BzbuLfUBc3//Zw0nDT7LCV7HAniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqkRexgW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqkRexgW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785120799; x=1816656799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8EdsphQ5OQ2t2aNq2urG7f9+JHxltMx8yHXvmDTCXw8=;
  b=BqkRexgWmSdcJUc37HOuNoipGwYd8xlijK+IQiqF88+ThaFLV16DdbgL
   gyKEI5hrGBAhm1WhQItr5MPsXEJjH9oZ7W8/HAT8ArVtL/i7UyFd6SuL+
   CpMvz/gwNtMsGTi7Yw3I+tfL39BQrE2uxP1NWbH3c6XMQIl5WAkhiUVDU
   vpUAdmqSaiOJJQx1DF5zVNS2/VE3e5J37XPltSx0KqIhiiwGdyRf9lK5w
   LCOXQ9bhZy/XaZF+1NmRMsbd9C2HmnINOqbMiUusRYkhk9FtR0st+NSuW
   YHvm6RDKIVmm14ng53ue+8142FXcRwQJ9OpJ/89YgIWynMimex1g/wmGv
   Q==;
X-CSE-ConnectionGUID: bxKdP/ezRSGW3N6+pOIUMA==
X-CSE-MsgGUID: eQUg9FYvQOmH7f2zY86p9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85873234"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="85873234"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 19:53:18 -0700
X-CSE-ConnectionGUID: ucNnDqWcRS+GSCHeKbcM4Q==
X-CSE-MsgGUID: ucihsfAJSwew1Rr0BJqarg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="264286239"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 19:53:16 -0700
Message-ID: <96cd129e-80a4-470e-af61-916bbf6874a0@linux.intel.com>
Date: Mon, 27 Jul 2026 10:51:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: use kstrtoint_from_user() in
 dmar_perf_latency_write()
To: Dmitry Antipov <dmantipov@yandex.ru>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <20260624070819.773161-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260624070819.773161-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/26 15:08, Dmitry Antipov wrote:
> Simplify 'dmar_perf_latency_write()' by using the convenient
> 'kstrtoint_from_user()'.
> 
> Signed-off-by: Dmitry Antipov<dmantipov@yandex.ru>
> ---
>   drivers/iommu/intel/debugfs.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)

Queued for v7.3-rc1. Thanks a lot!
