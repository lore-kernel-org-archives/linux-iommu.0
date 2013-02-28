From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/6] powerpc/fsl_pci: Added defines for the FSL PCI controller BRR1 register.
Date: Thu, 28 Feb 2013 09:46:51 -0600
Message-ID: <414263AA-3E4B-4748-AD06-94F869261841@kernel.crashing.org>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com> <1361191939-21260-4-git-send-email-Varun.Sethi@freescale.com> <20130227113336.GI26252@8bytes.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130227113336.GI26252@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Varun Sethi <Varun.Sethi@freescale.com>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, scottwood@freescale.com, stuart.yoder@freescale.com
List-Id: iommu@lists.linux-foundation.org


On Feb 27, 2013, at 5:33 AM, Joerg Roedel wrote:

> On Mon, Feb 18, 2013 at 06:22:16PM +0530, Varun Sethi wrote:
>> Macros for checking FSL PCI controller version.
>> 
>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>> ---
>> arch/powerpc/include/asm/pci-bridge.h |    4 ++++
>> 1 files changed, 4 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>> index 025a130..c12ed78 100644
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -14,6 +14,10 @@
>> 
>> struct device_node;
>> 
>> +/* FSL PCI controller BRR1 register */
>> +#define PCI_FSL_BRR1      0xbf8
>> +#define PCI_FSL_BRR1_VER 0xffff
>> +
> 
> 
> Please merge this patch with the one where you actually make use of
> these defines for the first time.
> 
> 
> 	Joerg

This also seems an odd place for these defines.

- k