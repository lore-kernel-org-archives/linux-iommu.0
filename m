From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Kernel Oops: iommu related?
Date: Thu, 12 Feb 2015 22:13:40 +0100
Message-ID: <20150212211340.GF29106@8bytes.org>
References: <54DCE8A6.4000608@compro.net> <20150212180846.GD29106@8bytes.org>
	<54DCF024.30309@compro.net> <54DD00FE.2050009@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54DD00FE.2050009-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 12, 2015 at 02:37:34PM -0500, Mark Hounschell wrote:
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.18.7-lcrs root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M cma=64M@0-4G audit=0 nohz=on nohz_full=4,5,6,7 rcu_nocbs=4,5,6,7 3

Oh, and can you please boot with 'amd_iommu_dump' on the kernel command
line and send me dmesg after boot?

Thanks,

	Joerg
