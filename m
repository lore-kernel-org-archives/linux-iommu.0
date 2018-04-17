From: "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
Date: Tue, 17 Apr 2018 13:46:12 -0400
Message-ID: <9123cd44-e01f-bff6-8441-792acbde10bc@amd.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
	<152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152302066417.47565.4017200105445420643.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 4/6/2018 9:17 AM, Gary R Hook wrote:
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
> 
> returns a pointer to the new dentry structure created for
> /sys/kernel/debug/iommu, or NULL in the event of a failure. An IOMMU
> driver should call this function first, and then create a directory
> beneath it. A driver implementation might look something like:
> 
> static struct dentry *my_debugfs;
> 
> 	struct dentry *d_top;
> 	if (!my_debugfs) {
> 		d_top = iommu_debugfs_setup();
> 		if (d_top)
> 			my_debugfs = debugfs_create_dir("vendor", d_top);
> 	}
> 
> Since the IOMMU driver can not be removed from the running system, this
> patch only provides an "on" function.
> 
> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/iommu/Kconfig         |   11 ++++++++
>   drivers/iommu/Makefile        |    1 +
>   drivers/iommu/iommu-debugfs.c |   58 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/iommu.h         |    4 +++
>   4 files changed, 74 insertions(+)
>   create mode 100644 drivers/iommu/iommu-debugfs.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f3a21343e636..c1e39dabfec2 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>   
>   endmenu
>   
> +config IOMMU_DEBUG
> +	bool "Enable IOMMU internals in DebugFS"
> +	depends on DEBUG_FS
> +	default n
> +	help
> +	  Allows exposure of IOMMU device internals. This option enables
> +	  the use of debugfs by IOMMU drivers as required. Devices can,
> +	  at initialization time, cause the IOMMU code to create a top-level
> +	  debug/iommu directory, and then populate a subdirectory with
> +	  entries as required.

I should explicitly ask about this:

Joerg had suggested IOMMU_DEBUGFS, but here I've changed to IOMMU_DEBUG. 
I'm not seeing a lot of CONFIG options that use DEBUGFS for debugfs 
options, so I chose to follow an implied convention.

Question: should this indeed be IOMMU_DEBUGFS?
                                 ^^^^^^^^^^^^^
