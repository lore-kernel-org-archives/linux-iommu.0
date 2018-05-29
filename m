From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 0/9] iommu/vt-d: Improve PASID id and table management
Date: Tue, 29 May 2018 13:56:05 +0200
Message-ID: <20180529115605.GI18595@8bytes.org>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
 <20180515141101.GF18595@8bytes.org>
 <5AFBE53C.2070604@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5AFBE53C.2070604@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 16, 2018 at 04:01:00PM +0800, Lu Baolu wrote:
> You are right. System-wide pasid space is necessary, hence PATCH
> 1~3 implement it. But PATCH 4~9 don't go into the opposite direction,
> it's designed to address another potential issue.

Okay, thanks for the clarification. Please send me a rebased version of
this after the merge window I will review again.


Thanks,

	Joerg
