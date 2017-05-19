From: Oza Oza via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v6 2/3] iommu/pci: reserve IOVA for PCI masters
Date: Fri, 19 May 2017 06:51:28 +0530
Message-ID: <CAMSpPPfnhSb3w4te=k5aHGoC6wgn0iu7EAvc5gxwxGnNe4JehQ@mail.gmail.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
	<1494912127-12890-3-git-send-email-oza.oza@broadcom.com>
	<20170517171154.GF31462@bhelgaas-glaptop.roam.corp.google.com>
Reply-To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170517171154.GF31462-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 17, 2017 at 10:41 PM, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, May 16, 2017 at 10:52:06AM +0530, Oza Pawandeep wrote:
>> this patch reserves the IOVA for PCI masters.
>> ARM64 based SOCs may have scattered memory banks.
>> such as iproc based SOC has
>>
>> <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
>> <0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
>> <0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
>> <0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */
>>
>> but incoming PCI transcation addressing capability is limited
>
> s/transcation/transaction/
>
>> by host bridge, for example if max incoming window capability
>> is 512 GB, then 0x00000090 and 0x000000a0 will fall beyond it.
>>
>> to address this problem, iommu has to avoid allocating IOVA which
>
> s/iommu/IOMMU/
>
>> are reserved. which inturn does not allocate IOVA if it falls into hole.
>
> s/inturn/in turn/

Hi Bjorn,

Thank you for the comments.
Will take care of all your comments.

Regards,
Oza.
