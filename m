From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 3/4] iommu/vt-d: Clean up pasid quirk for pre-production devices
Date: Sat, 07 Jul 2018 08:01:22 +0100
Message-ID: <153094688126.17577.10340360451966114779@cwilso3-mobl.ger.corp.intel.com>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
 <1525410499-18632-4-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525410499-18632-4-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, "Balestrieri, Francesco" <francesco.balestrieri@intel.com>
List-Id: iommu@lists.linux-foundation.org

Quoting Lu Baolu (2018-05-04 06:08:18)
> The pasid28 quirk is needed only for some pre-production devices.
> Remove it to make the code concise.

Every skylake mixing iommu and i915 is now inoperable on boot. Reads
by the GPU from iommu map pages return zero, writes disappear into the
void, no errors flagged.

Please revert until the matter is resolved.
-Chris
