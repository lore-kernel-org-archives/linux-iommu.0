From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/3] iommu/pci: reserve IOVA for PCI masters
Date: Wed, 17 May 2017 12:11:54 -0500
Message-ID: <20170517171154.GF31462@bhelgaas-glaptop.roam.corp.google.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
	<1494912127-12890-3-git-send-email-oza.oza@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1494912127-12890-3-git-send-email-oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 16, 2017 at 10:52:06AM +0530, Oza Pawandeep wrote:
> this patch reserves the IOVA for PCI masters.
> ARM64 based SOCs may have scattered memory banks.
> such as iproc based SOC has
> 
> <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
> <0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
> <0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
> <0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */
> 
> but incoming PCI transcation addressing capability is limited

s/transcation/transaction/

> by host bridge, for example if max incoming window capability
> is 512 GB, then 0x00000090 and 0x000000a0 will fall beyond it.
> 
> to address this problem, iommu has to avoid allocating IOVA which

s/iommu/IOMMU/

> are reserved. which inturn does not allocate IOVA if it falls into hole.

s/inturn/in turn/
