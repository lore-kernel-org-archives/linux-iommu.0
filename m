Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584C7C
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663598630; x=1695134630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4siBz6Id31VkpgPWyEtZoK8L5eH6fa5oS1U9xUtoxk=;
  b=Sr9ygV7LB+fDA5brarUugMFSwPlwb+h0g5cCa2EOaSXsqCv07CKgFWLk
   CiqmnRW2yA1b29yHsv4rfz76tQ0c0BPLwHurtOZfAKd247DqStgcs1JNm
   sX7cumx0zEgMXrUBo9OWBvx2m54w1uygWiJPbDdYPrJlA9hp80eRQRf6m
   80hD0paZL5k6SZtcYVDiV/gTuAaMRcfYIuPz01CNQ4Ee+Lq5R+iZHtxmB
   F08Vkl0mdhiWRhf8wnX24KgvMy85A5A7+jMdEoJslG+3t+QDflEn5NbB5
   0lmVeBtkTHMp/C1kCmBK16xc4CXOriiMsDBc3lmHQiY3s7ZI/k6yl+lZD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="385707120"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="385707120"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 07:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="707589263"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2022 07:43:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 12237363; Mon, 19 Sep 2022 17:44:04 +0300 (EEST)
Date: Mon, 19 Sep 2022 17:44:04 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: George Hilliard <thirtythreeforty@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 5.19.9 regression: DMAR error on i7-8650U
Message-ID: <YyiANMVWGc4Bvpj9@black.fi.intel.com>
References: <485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com>
 <4379585e-42e4-53d9-8ca4-bf5b8ff3c95d@linux.intel.com>
 <Yyf9uIzwbb6O2E7o@black.fi.intel.com>
 <YygjnTyX+wNzIt5k@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YygjnTyX+wNzIt5k@black.fi.intel.com>

Hi Baolu,

On Mon, Sep 19, 2022 at 11:09:02AM +0300, Mika Westerberg wrote:
> Here's bugzilla report that looks to have similar symptoms:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=216497

The reporters of the above bugzilla bisected this down to:

  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.19.y&id=9516acba29e322202674d18f4dc383879f7813a5
