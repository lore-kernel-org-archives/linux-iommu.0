Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349A38757D
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424366; cv=none; b=DgidFMWy3M504IO0PlrMNfGDqDAf/ljJQp5TkxUsfUkdUSBPKGMewT7EfBt9W70oNxOjviAB7e+p7U/XFMBwdVt2gFuTG19KP/upFLYiIB42J166icMiRaLpP7Dy/7NdrDJypFszKTyf1rDzrm+GyBQ7MEiR3ssstZM1GnjoYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424366; c=relaxed/simple;
	bh=yiz2PehtSMquqBrVvkBsz2/yoRKCJo3RdQRq0Fwa+XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6CVRT4DZLQS3+pKigOhxK5OT2aRDbRvbXD5cls5i0foVpZTw1TrnP92Ct8IJA6cWYLs0fJQjkenFEAVoAC/XyaDwE8AsD9XMe1LJMETHtaXNNBovbSTw/xE4wi/0qjUXZ8L2+Semg/6mrMFAcstXVPezWLqGw2vbuS51PkmL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RykrkdWY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RykrkdWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788424363; x=1819960363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yiz2PehtSMquqBrVvkBsz2/yoRKCJo3RdQRq0Fwa+XA=;
  b=RykrkdWYbzJAq6RKXDeHAR7AVhUgMun/jnFNUvOHjoHKgirocYWYTJmP
   Ur73A60JbEDqjPBl0ciKXH8v3cSMDFFlc+6BpcBLBzJhsQC1SL0PftM2L
   yDdksUNw3vfz1mZY1qID9Pe5RPOWqCuUJwrxxEfiKXPRgTgf8xOTclMFy
   XwMkgOVGaJZSQ/8fZWxQUTk4SQOzAwhalpjzYUHRnZZfthfqZfu7Pt3Av
   VPT+eLFluOCPX7ECtWFE+t800dyVf6EtLphqt+dAeQAC4zGhCgnkchJ/Q
   5RpHWwo4vRDeiO3itAqytBDJCmcA24FiJ16OoikSM1sBqaU3vEYNxHB9B
   w==;
X-CSE-ConnectionGUID: TOx12F6YTja4hrp6Ozi0zw==
X-CSE-MsgGUID: 4dmqJDrySJynK4gHf5EQwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88040820"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88040820"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:32:39 -0700
X-CSE-ConnectionGUID: 3GHFLDY8RtqR2LqnOOn0vg==
X-CSE-MsgGUID: uXNdGxW0RRCrcibYp5fMzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307861818"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.90]) ([10.245.244.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:32:36 -0700
Message-ID: <41737353-533e-4d50-b687-272e6cbde36a@linux.intel.com>
Date: Thu, 3 Sep 2026 11:32:33 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [BUG v7.3-rc1] WARNING: mm/page_alloc.c:5340 at
 __alloc_frozen_pages_noprof
To: Michal Pecio <michal.pecio@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20260902143351.7b6d5e0a@gandalf.local.home>
 <20260903091556.751544ce.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260903091556.751544ce.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/26 10:15, Michal Pecio wrote:
> On Wed, 2 Sep 2026 14:33:51 -0400, Steven Rostedt wrote:
>> I'm triggering this warning on boot:
>>
>> [   32.862044] ------------[ cut here ]------------
>> [   32.864573] WARNING: mm/page_alloc.c:5340 at __alloc_frozen_pages_noprof+0xd81/0x30d0, CPU#3: swapper/0/1
> 
> Apparently that's a nonsense allocation size.
> 
>> [   32.881048] Modules linked in:
>> [   32.883735] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-test #510 PREEMPT(full)
>> [   32.890178] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> 
> Hmm, I recall hearing about QEMU recently.
> 
> Could this be the "horrible splat" mentioned by 045b5bef916d ?
> 
> Find it in usb-linus branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> 
Yes, this is the case

A patch switching to GENMASK and FIELD_GET has a flaw and changed the parsing of
the max segments value reported by xHCI host controller.

xHC returns _exponent_ of maximum segments supported, QEMU supports one segment
so value read is 0.  Parsing fails and assumes maximum number of supported ring segments
is 0.  Most hardware xHCI controllers (except some Mediatek) support more than one
segments so issue is not visible for those

Issue (7.3-rc1):
6d45e9556d4a  ("usb: xhci: standardize multi bit-field macros") in parsing

Fix: (in Greg's tree, Hopeful it can make make 7.3-rc2)
045b5bef916d usb: xhci: Fix HCS_ERST_MAX conversion

Thanks
Mathias
