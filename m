From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] iommu: Move swap_pci_ref function to pci.h.
Date: Mon, 15 Apr 2013 09:34:11 -0600
Message-ID: <CAErSpo7gsSLsa1DOix7-LRqQbpfFuf3=KAubXhwCEuqA7041EQ@mail.gmail.com>
References: <1365966722-1804-1-git-send-email-Varun.Sethi@freescale.com>
	<20130415145834.GR6858@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130415145834.GR6858-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 15, 2013 at 8:58 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Apr 15, 2013 at 12:42:00AM +0530, Varun Sethi wrote:
>> swap_pci_ref function is used by the IOMMU API code for swapping pci device
>> pointers, while determining the iommu group for the device.
>> Currently this function was being implemented for different IOMMU drivers.
>> This patch moves the function to pci.h so that the implementation can be
>> shared across various IOMMU drivers.
>
> The function is only used in IOMMU code, so I think its fine to keep it
> there (unless Bjorn disagrees and wants it in PCI code).

I agree; I don't think there's much benefit in putting something under
#ifdef CONFIG_IOMMU_API into pci.h.  Maybe there is or could be a
shared iommu header file?

Bjorn
