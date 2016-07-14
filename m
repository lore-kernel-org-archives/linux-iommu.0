From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: IOMMU+DMAR causing NMIs-s
Date: Thu, 14 Jul 2016 10:31:06 +0200
Message-ID: <20160714083106.GQ12639@8bytes.org>
References: <alpine.LRH.2.20.1607131122010.20366@math.ut.ee>
	<20160713090332.GK12639@8bytes.org>
	<alpine.LRH.2.20.1607131239410.20366@math.ut.ee>
	<20160713094917.GM12639@8bytes.org>
	<alpine.LRH.2.20.1607131257390.20366@math.ut.ee>
	<20160713101859.GO12639@8bytes.org>
	<20160713084830.09453584@t450s.home>
	<1a4c4b65-c716-08a5-af89-1b0f551024ed@hpe.com>
	<alpine.LRH.2.20.1607132258001.30020@math.ut.ee>
	<20160713170408.6e5d2534@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160713170408.6e5d2534-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 13, 2016 at 05:04:08PM -0600, Alex Williamson wrote:
> With hpwdt disabled, can you reboot a few times and look for DMAR
> faults in the dmesg to see if they're all consistent, ie. device 1e.0
> doing a read from 0xb000?  Is there any correlation to radeon hanging
> and one of those DMAR faults appearing in the log (you can make use of
> the iLO for a serial console so you can record more of the boot than
> what can be captured on the VGA console).  Also, this should be an
> X58-based system, which reminds me of Joerg's recent commit
> a4c34ff1c029 that's intended to fix a hang on such systems.  That was
> included starting in v4.7-rc4, so if this is a new issue, testing
> before and after that commit might be relevant.  Thanks,

That commit fixed a hang while the IOMMU is being initialized. This hang
is different, as the IOMMU already runs. So I doubt that it fixes this
problem, but it is worth a test, of course.


	Joerg
