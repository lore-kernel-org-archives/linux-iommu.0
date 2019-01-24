From: Srinath Mannam via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 0/3] Add IPROC PCIe new features
Date: Thu, 24 Jan 2019 11:06:44 +0530
Message-ID: <CABe79T6=2uf1SrpDEm9s3smDkcR0JB-Gq8VwDF4yL8zBL6w0zw@mail.gmail.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
	<20190118144149.GA25249@google.com>
Reply-To: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190118144149.GA25249-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
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
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

Thank you for the review. I will address your comments in the next patchset.

Regards,
Srinath.

On Fri, Jan 18, 2019 at 8:11 PM Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Fri, Jan 18, 2019 at 09:53:20AM +0530, Srinath Mannam wrote:
> > Add changes related to IPROC PCIe RC IP new features.
> >
> > This patch set is based on Linux-5.0-rc2.
> >
> > Srinath Mannam (3):
> >   PCI: iproc: Add feature to set order mode
>
> Since this apparently refers to a PCIe feature, the subject should use the
> exact terminology used in the PCIe spec.
>
> >   PCI: iproc: CRS state check in config request
>
> This subject should start with a verb, not "CRS".
>
> >   PCI: iproc: Add PCIe 32bit outbound memory configuration
> >
> >  drivers/pci/controller/pcie-iproc.c | 172 +++++++++++++++++++++++++++++++++++-
> >  drivers/pci/controller/pcie-iproc.h |  16 ++++
> >  2 files changed, 184 insertions(+), 4 deletions(-)
> >
> > --
> > 2.7.4
> >
