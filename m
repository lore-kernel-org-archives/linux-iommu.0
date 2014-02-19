From: "Winkler, Tomas" <tomas.winkler@intel.com>
Subject: Re: [PATCH v2 2/4] mei: Add include of
	<linux/irqreturn.h>
Date: Wed, 19 Feb 2014 08:29:52 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B1AF74107@HASMSX106.ger.corp.intel.com>
References: <20140218205925.11014.14973.stgit@bhelgaas-glaptop.roam.corp.google.com>
	<20140218205946.11014.13654.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <e1000-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20140218205946.11014.13654.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=e1000-devel>
List-Post: <mailto:e1000-devel@lists.sourceforge.net>
List-Help: <mailto:e1000-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: e1000-devel-bounces@lists.sourceforge.net
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "e1000-devel@lists.sourceforge.net" <e1000-devel@lists.sourceforge.net>, Joerg Roedel <joro@8bytes.org>, "Dutt, Sudeep" <sudeep.dutt@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org



> 
> We currently include <linux/irqreturn.h> in <linux/pci.h>, but I'm about to
> remove that from linux/pci.h, so add explicit includes where needed.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/misc/mei/hw-me.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
> index 80bd829fbd9a..893d5119fa9b 100644
> --- a/drivers/misc/mei/hw-me.h
> +++ b/drivers/misc/mei/hw-me.h
> @@ -20,6 +20,7 @@
>  #define _MEI_INTERFACE_H_
> 
>  #include <linux/mei.h>
> +#include <linux/irqreturn.h>
>  #include "mei_dev.h"
>  #include "client.h"


Okay.
> 

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
E1000-devel mailing list
E1000-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/e1000-devel
To learn more about Intel&#174; Ethernet, visit http://communities.intel.com/community/wired
