From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 1/2] iommu - Enable debugfs exposure of the IOMMU
Date: Thu, 3 May 2018 15:44:02 +0200
Message-ID: <20180503134402.uqn2y6pso5so2pl7@8bytes.org>
References: <152511783026.8963.5818249217042882958.stgit@taos>
 <152511832970.8963.10801049423048266747.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152511832970.8963.10801049423048266747.stgit@taos>
Sender: linux-kernel-owner@vger.kernel.org
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 30, 2018 at 02:58:49PM -0500, Gary R Hook wrote:
> Provide base enablement for using debugfs to expose internal data of
> an IOMMU driver. When called, create the /sys/kernel/debug/iommu
> directory.  Emit a strong warning at boot time to indicate that this
> feature is enabled.
> 
> This patch adds a top-level function that will create the (above)
> directory, under which a driver may create a hw-specific directory for
> its use. The function
> 
> 	iommu_debugfs_setup()

That function should be called in iommu core-code, in case we want to
export some generic information from there.

Each driver then calls a separate function like

	dentry = iommu_debugfs_driver_dir("amd_iommu");

to create a driver-specific directory.

> +config IOMMU_DEBUGFS
> +	bool "Enable IOMMU internals in DebugFS"

s/Enable/Export/

> + * static struct dentry *my_debugfs;
> + *
> + *    struct dentry *d_top;

Missing newline

> + *    if (!my_debugfs) {
> + *        d_top = iommu_debugfs_setup();
> + *        if (d_top)
> + *            my_debugfs = debugfs_create_dir("vendor", d_top);
> + *    }
> + *
> + * Since the IOMMU driver can not be removed from the running system, there
> + * is no need for an "off" function.
> + */
> +struct dentry *iommu_debugfs_setup(void)
> +{
> +	if (!iommu_debugfs_dir) {
> +		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
> +		if (iommu_debugfs_dir)
> +			pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL\n");

This warning needs to be a lot bigger. See the trace_printk() warning
for an example of what I have in mind.
