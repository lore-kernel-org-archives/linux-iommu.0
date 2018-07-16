From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 00/10] iommu/vt-d: Add scalable mode support
Date: Mon, 16 Jul 2018 11:51:57 +0100
Message-ID: <07fe2e3f-4f4a-58db-ee2a-2620183d93b2@arm.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com
List-Id: iommu@lists.linux-foundation.org

Hi,

On 16/07/18 07:49, Lu Baolu wrote:
> Intel vt-d rev3.0 [1] introduces a new translation mode called
> 'scalable mode', which enables PASID-granular translations for
> first level, second level, nested and pass-through modes. The
> vt-d scalable mode is the key ingredient to enable Scalable I/O
> Virtualization (Scalable IOV) [2] [3], which allows sharing a
> device in minimal possible granularity (ADI - Assignable Device
> Interface). It also includes all the capabilities required to
> enable Shared Virtual Addressing (SVA). As a result, previous
> Extended Context (ECS) mode is deprecated (no production ever
> implements ECS).
> 
> Each scalable mode pasid table entry is 64 bytes in length, with
> fields point to the first level page table and the second level
> page table. The PGTT (Pasid Granular Translation Type) field is
> used by hardware to determine the translation type.

Looks promising! Since the 2nd level page tables are in the PASID entry,
the hypervisor traps guest accesses to the PASID tables instead of
passing through the whole PASID directory? Are you still planning to use
the VFIO BIND_PASID_TABLE interface in this mode, or a slightly
different one for individual PASIDs?

Thanks,
Jean
