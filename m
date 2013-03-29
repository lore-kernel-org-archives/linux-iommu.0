From: Justin Piszcz <jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org>
Subject: Re: [PATCH] Quirk to support Marvell 88SE91xx SATA controllers with
	Intel IOMMU.
Date: Fri, 29 Mar 2013 10:36:33 -0400
Message-ID: <CAO9zADxcQrUBYsOZST7C0RmMuWEPZjsqroM_LL82sGbt4+qZWA@mail.gmail.com>
References: <1354533387-4110-1-git-send-email-acooks@gmail.com>
	<1355914703-28576-1-git-send-email-acooks@gmail.com>
	<1362126373-32318-1-git-send-email-acooks@gmail.com>
	<CAO9zADxjoP+R9ccz7vMPmcFvdYwNjErSjaWc_RFkW_FY3+SK=w@mail.gmail.com>
	<CAJtEV7Zs2BiwJ9jdDeoceh9hiVXvVaSvj=9H+4+vEzhY72AS9g@mail.gmail.com>
	<00b701ce16d3$0aabe0f0$2003a2d0$@lucidpixels.com>
	<CAJtEV7bvPORPoXgQY2OahNVMj+SY5z=xxQ=nueX7=kLVfpyF_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAJtEV7bvPORPoXgQY2OahNVMj+SY5z=xxQ=nueX7=kLVfpyF_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chu Ying <gm.ychu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, YingChu <xjtuychu-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "open list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Mar 3, 2013 at 8:35 PM, Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Sat, Mar 2, 2013 at 7:18 AM, Justin Piszcz <jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org> wrote:
>>
>> Against a clean 3.7.10 (from ftp.kernel.org)
>>
>> # patch -p1 <
>> ../patch/RFC-Fix-Intel-IOMMU-support-for-Marvell-88SE91xx-SATA-controllers..
>> patch
>> patching file drivers/iommu/intel-iommu.c
>> patching file drivers/pci/quirks.c
>> Hunk #1 succeeded at 3230 (offset 3 lines).
>> patching file include/linux/pci.h
>> # pwd
>> /usr/src/linux-3.7.10
>>
>
> I've downloaded and patched the 3.7.10 tarball and still get the same
> output I got before; different output from yours. I'm not sure the
> patch is complete or applying correctly, are you?
> Could you please check whether the patch you're applying is the same

Hi,

As this patch is now working for some time (against 3.7.x), I was
wondering when it was going to be included in mainline?

I had upgraded to 3.8.x and rebooted and the same problem recurred and
had to revert back to 3.7.x.

Thanks,

Justin.
