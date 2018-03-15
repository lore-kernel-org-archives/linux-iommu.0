From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix a potential memory leak
Date: Thu, 15 Mar 2018 15:16:36 +0100
Message-ID: <20180315141636.cel3dqr4pzxfgtb3@8bytes.org>
References: <1519450947-9760-1-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1519450947-9760-1-git-send-email-baolu.lu@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "# v4 . 4+" <stable@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Feb 24, 2018 at 01:42:27PM +0800, Lu Baolu wrote:
> A memory block was allocated in intel_svm_bind_mm() but never freed
> in a failure path. This patch fixes this by free it to avoid memory
> leakage.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Applied, thanks.
