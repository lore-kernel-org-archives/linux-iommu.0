From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 0/9] iommu/vt-d: Improve PASID id and table management
Date: Wed, 30 May 2018 08:56:20 +0800
Message-ID: <5B0DF6B4.1040908@linux.intel.com>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
 <20180515141101.GF18595@8bytes.org> <5AFBE53C.2070604@linux.intel.com>
 <20180529115605.GI18595@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529115605.GI18595@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 05/29/2018 07:56 PM, Joerg Roedel wrote:
> On Wed, May 16, 2018 at 04:01:00PM +0800, Lu Baolu wrote:
>> You are right. System-wide pasid space is necessary, hence PATCH
>> 1~3 implement it. But PATCH 4~9 don't go into the opposite direction,
>> it's designed to address another potential issue.
> Okay, thanks for the clarification. Please send me a rebased version of
> this after the merge window I will review again.

Sure.

Best regards,
Lu Baolu
