From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] Save and restore pci properties to support FLR
Date: Tue, 30 May 2017 15:58:53 -0500
Message-ID: <20170530205853.GB14896@bhelgaas-glaptop.roam.corp.google.com>
References: <1496161549-167468-1-git-send-email-ashok.raj@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1496161549-167468-1-git-send-email-ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, May 30, 2017 at 09:25:47AM -0700, Ashok Raj wrote:
> Resending Jean's patch so it can be included earlier than his large
> SVM commits. Original patch https://patchwork.kernel.org/patch/9593891
> was ack'ed by Bjorn. Let's commit these separately since we need
> functionality earlier.
> 
> Resending this series as requested by Jean.
> 
> CQ Tang (1):
>   PCI: Save properties required to handle FLR for replay purposes.
> 
> Jean-Philippe Brucker (1):
>   PCI: Cache PRI and PASID bits in pci_dev
> 
>  drivers/pci/ats.c       | 88 ++++++++++++++++++++++++++++++++++++++++---------
>  drivers/pci/pci.c       |  3 ++
>  include/linux/pci-ats.h | 10 ++++++
>  include/linux/pci.h     |  8 +++++
>  4 files changed, 94 insertions(+), 15 deletions(-)

Applied to pci/virtualization for v4.13.  See response to 2/2 for minor
changes I made there.
