Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B2010F9
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 08:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663661798; x=1695197798;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oN0Y6PERKnuQ7F62YC4ctrGjC25b7kmf1Cl0cTZH9Ic=;
  b=ks1JuiN4DjG2DC3ZyxcnLvcUOOmPvIYrUaH5hvhIlYwbcBkYRFZ0E6WH
   /fFuL8N6dwEqrPRtpSfkRxTqcBZ3m/i0IR98ZAdla0jNm1aHQxnhXhSd2
   ObU7UhyY9gx1N/XdApGBbGlLLAJavtBY61N17rwFUvNPRxH3383WP762s
   JFkz+YLX8W2RcTKpPcQZ2PB4n1PUiOHCHRB9JgYgDaNTKKS767BrmMYCL
   PD2+gD4AQuVnn5RWPfYUcCuIx1d5jRE6xTINM/0TEXSzTjqNi5CWtyBFQ
   nhH11tdmzc3HE2a0/inw2ikRH2311WWhep4G4T0TWfJ2aGZeaO/OxprEj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363590415"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="363590415"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:16:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="621174648"
Received: from litengx-mobl.ccr.corp.intel.com (HELO [10.254.208.130]) ([10.254.208.130])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:16:35 -0700
Message-ID: <b003e86c-1cec-e6b1-1717-7c63372040ac@linux.intel.com>
Date: Tue, 20 Sep 2022 16:16:33 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux1394-devel@lists.sourceforge.net"
 <linux1394-devel@lists.sourceforge.net>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 5.19.9 regression: DMAR error on i7-8650U
Content-Language: en-US
To: George Hilliard <thirtythreeforty@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com>
 <4379585e-42e4-53d9-8ca4-bf5b8ff3c95d@linux.intel.com>
 <Yyf9uIzwbb6O2E7o@black.fi.intel.com> <YygjnTyX+wNzIt5k@black.fi.intel.com>
 <YyiANMVWGc4Bvpj9@black.fi.intel.com>
 <CACmrr9joJi5v2DOu4AAX3tyWDxM5LV+bviRZHeesdp37b+8gRQ@mail.gmail.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CACmrr9joJi5v2DOu4AAX3tyWDxM5LV+bviRZHeesdp37b+8gRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/20 3:05, George Hilliard wrote:
> On Mon, Sep 19, 2022 at 9:43 AM Mika Westerberg
> <mika.westerberg@linux.intel.com>  wrote:
>> Hi Baolu,
>>
>> On Mon, Sep 19, 2022 at 11:09:02AM +0300, Mika Westerberg wrote:
>>> Here's bugzilla report that looks to have similar symptoms:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=216497
>> The reporters of the above bugzilla bisected this down to:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.19.y&id=9516acba29e322202674d18f4dc383879f7813a5
> I can confirm that reverting 9516acba29e322202674d18f4dc383879f7813a5
> fixes the problem for me as well.

Thanks for doing this. I will post a patch to revert this commit.

Best regards,
baolu
