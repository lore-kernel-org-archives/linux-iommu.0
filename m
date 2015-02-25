From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU is
 blocked
Date: Wed, 25 Feb 2015 18:50:11 -0300
Message-ID: <20150225215011.GA16848@amt.cnet>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <1418397300-10870-25-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418397300-10870-25-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Wu <feng.wu@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, gleb@kernel.org, pbonzini@redhat.com, dwmw2@infradead.org, joro@8bytes.org, alex.williamson@redhat.com, jiang.liu@linux.intel.com, eric.auger@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 12, 2014 at 11:14:58PM +0800, Feng Wu wrote:
> This patch updates the Posted-Interrupts Descriptor when vCPU
> is blocked.
> 
> pre-block:
> - Add the vCPU to the blocked per-CPU list
> - Clear 'SN'
> - Set 'NV' to POSTED_INTR_WAKEUP_VECTOR
> 
> post-block:
> - Remove the vCPU from the per-CPU list
> 
> Signed-off-by: Feng Wu <feng.wu@intel.com>
> ---

Don't see this is needed, can use the existing POSTED_INTR_VECTOR:

If in guest mode, IPI will be handled in VMX non-root by performed
PIR->IRR transfer.

If outside guest mode, POSTED_INTR_VECTOR IPI will be handled by host
which can wakeup the guest (in case it is halted).
