From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/4] dma-debug: Use pr_fmt()
Date: Tue, 04 Dec 2018 09:35:08 -0800
Message-ID: <062cb874560a1850d7263a8023ce827f32105fc9.camel@perches.com>
References: <cover.1543856576.git.robin.murphy@arm.com>
         <7d37a451d27828d487d69c7a0662dbe46ece06ec.1543856576.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7d37a451d27828d487d69c7a0662dbe46ece06ec.1543856576.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Mon, 2018-12-03 at 17:28 +0000, Robin Murphy wrote:
> Use pr_fmt() to generate the "DMA-API: " prefix consistently. This
> results in it being added to a couple of pr_*() messages which were
> missing it before, and for the err_printk() calls moves it to the actual
> start of the message instead of somewhere in the middle.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> I chose not to refactor the existing split strings for minimal churn here.
> 
>  kernel/dma/debug.c | 74 ++++++++++++++++++++++++----------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 231ca4628062..91b84140e4a5 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -17,6 +17,8 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>   */
>  
> +#define pr_fmt(fmt)	"DMA-API: " fmt
> +
>  #include <linux/sched/task_stack.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
> @@ -234,7 +236,7 @@ static bool driver_filter(struct device *dev)
>  		error_count += 1;					\
>  		if (driver_filter(dev) &&				\
>  		    (show_all_errors || show_num_errors > 0)) {		\
> -			WARN(1, "%s %s: " format,			\
> +			WARN(1, pr_fmt("%s %s: ") format,		\
>  			     dev ? dev_driver_string(dev) : "NULL",	\
>  			     dev ? dev_name(dev) : "NULL", ## arg);	\
>  			dump_entry_trace(entry);			\

I think converting this WARN to

			dev_err(dev, format, ##__VA_ARGS__);
			dump_stack();

would look better and be more intelligible.

Perhaps add a #define for dev_fmt if really necessary.
