From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/6] iommu/arm-smmu: Introduce bus notifier block
Date: Thu, 31 Oct 2013 00:46:53 +0000
Message-ID: <20131031004653.GB28613@mudshark.cambridge.arm.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
 <1382127195-15261-3-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1382127195-15261-3-git-send-email-andreas.herrmann@calxeda.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas Herrmann <andreas.herrmann@calxeda.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 18, 2013 at 09:13:11PM +0100, Andreas Herrmann wrote:
> At the moment just handle BUS_NOTIFY_BIND_DRIVER to conditionally
> isolate all master devices for an SMMU.
> 
> Depending on DT information each device is put into its own protection
> domain (if possible).  For configuration with one or just a few
> masters per SMMU that is easy to achieve.
> 
> In case of many devices per SMMU (e.g. MMU-500 with it's distributed
> translation support) isolation of each device might not be possible --
> depending on number of available SMR groups and/or context banks.
> 
> Default is that device isolation is contolled per SMMU with SMMU node
> property "arm,smmu-isolate-devices" in a DT. If this property is set
> for an SMMU node, device isolation is performed.
> 
> W/o device isolation the driver detects SMMUs but no translation is
> configured (transactions just bypass translation process).
> 
> Note that for device isolation dma_base and size are fixed as 0 and
> SZ_128M at the moment.

I still think we need to solve the base/size issue before these can be
merged (the option parsing code in patch 1 looks fine).

Maybe we could it all on demand by registering a fault handler with an
empty IOMMU domain?

Will
