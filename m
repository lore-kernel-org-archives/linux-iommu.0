From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: BUG at drivers/iommu/amd_iommu.c:1436!
Date: Thu, 17 Nov 2016 23:00:45 +0100
Message-ID: <20161117220045.GD2078@8bytes.org>
References: <838275de-6cac-93d8-ca04-54b06a24b3d4@compro.net>
	<20161117214141.GC2078@8bytes.org>
	<f4ababc2-64bf-fd0e-1d18-cb5963d23eb1@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f4ababc2-64bf-fd0e-1d18-cb5963d23eb1-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 17, 2016 at 04:53:24PM -0500, Mark Hounschell wrote:
> On 11/17/2016 04:41 PM, Joerg Roedel wrote:
> >Hi Mark,
> >
> >On Thu, Nov 17, 2016 at 02:13:59PM -0500, Mark Hounschell wrote:
> >>Kernel version is 4.8.0. No failure when the IOMMU is disabled. This
> >>is an out of tree GPL driver using
> >>pci_alloc_consistent/pci_free_consistent. The free causes this.
> >
> >Can you please run the driver with dma-api debugging enabled? Does it
> >trigger any warnings?
> >
> 
> It's been a while since I've done that for ya. Kernel config
> options? Kernel cmd line you want?

Just enable CONFIG_DMA_API_DEBUG and boot the resulting kernel. Please
send me full dmesg when the issue happens again.



	Joerg
