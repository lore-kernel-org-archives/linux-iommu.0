From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ath9k and AMD IOMMU alias breakage on 3.16?
Date: Fri, 05 Sep 2014 22:01:44 -0600
Message-ID: <1409976104.2982.56.camel@ul30vt.home>
References: <CAGou9MhCmRajqfh91rxbBUr9PBvJxo7U=g9p4Onp0pJk4BwBnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAGou9MhCmRajqfh91rxbBUr9PBvJxo7U=g9p4Onp0pJk4BwBnA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jason Newton <nevion-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2014-09-05 at 20:00 -0700, Jason Newton wrote:
> Hi,
> 
> I have an AR9462 connected over minipcie, it came with the ASRock
> FM2A88x-itx motherboard and I'm using an AMD A10-7850K cpu with it.  When I
> have IOMMU enabled, and this is desirable for opencl related things, the
> AR9462 malfunctions with these two errors occurring:
> 
> AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:00.1
> address=0x000000fdf8080020 flags=0x0a00]
> 
> Followed by this  looping error, which reoccurs shortly after associating
> and obtaining an IP.  I've attached a large snippet from dmesg, due to it's
> length.
> 
> I'm not sure where the error is coming from but I did see that Alex
> Williamson posted a patch that dealt with aliased devices (like pci
> bridges) and AMD's IOMMU issues, see
> e028a9e6b8a637af09ac4114083280df4a7045f1 for reference.
> 
> I then disable IOMMU in the bios, and immediately the ath9k/AR9462 pair is
> working without flaw or retries.  Bios is up to date btw, updated it after
> building the machine last friday.
> 
> So anyone have a clue what's going on here?

Please boot with "amd_iommu_dump" on the kernel boot line and send the
full dmesg log and 'sudo lspci -vvv' output.  Thanks,

Alex
