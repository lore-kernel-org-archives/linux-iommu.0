From: "Justin Piszcz" <jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org>
Subject: RE: [PATCH] Quirk to support Marvell 88SE91xx SATA controllers with
	Intel IOMMU.
Date: Fri, 1 Mar 2013 18:18:10 -0500
Message-ID: <00b701ce16d3$0aabe0f0$2003a2d0$@lucidpixels.com>
References: <1354533387-4110-1-git-send-email-acooks@gmail.com>	<1355914703-28576-1-git-send-email-acooks@gmail.com>	<1362126373-32318-1-git-send-email-acooks@gmail.com>	<CAO9zADxjoP+R9ccz7vMPmcFvdYwNjErSjaWc_RFkW_FY3+SK=w@mail.gmail.com>
	<CAJtEV7Zs2BiwJ9jdDeoceh9hiVXvVaSvj=9H+4+vEzhY72AS9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAJtEV7Zs2BiwJ9jdDeoceh9hiVXvVaSvj=9H+4+vEzhY72AS9g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Andrew Cooks' <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'Chu Ying' <gm.ychu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "'open list:INTEL IOMMU (VT-d)'" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'YingChu' <xjtuychu-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "'open list:PCI SUBSYSTEM'" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, 'David Woodhouse' <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, 'open list' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



-----Original Message-----
From: Andrew Cooks [mailto:acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] 
Sent: Friday, March 01, 2013 5:19 PM
To: Justin Piszcz
Cc: Joerg Roedel; YingChu; Chu Ying; Alex Williamson; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org;
David Woodhouse; open list:INTEL IOMMU (VT-d); open list; open list:PCI
SUBSYSTEM
Subject: Re: [PATCH] Quirk to support Marvell 88SE91xx SATA controllers with
Intel IOMMU.

On Sat, Mar 2, 2013 at 1:51 AM, Justin Piszcz <jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org>
wrote:
>
>

> Thanks for testing!
No problem.

Against a clean 3.7.10 (from ftp.kernel.org)

# patch -p1 <
../patch/RFC-Fix-Intel-IOMMU-support-for-Marvell-88SE91xx-SATA-controllers..
patch 
patching file drivers/iommu/intel-iommu.c
patching file drivers/pci/quirks.c
Hunk #1 succeeded at 3230 (offset 3 lines).
patching file include/linux/pci.h
# pwd
/usr/src/linux-3.7.10

Full dmesg with the patch applied: (but with IOMMU off)
http://home.comcast.net/~jpiszcz/20130301/dmesg-full.txt

Full dmesg (as much as possible through netconsole with IOMMU on)
http://home.comcast.net/~jpiszcz/20130301/dmesg-iommu-on.txt

Let me know if anything else is needed, thanks.

Justin.
