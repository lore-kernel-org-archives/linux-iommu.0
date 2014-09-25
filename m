From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 1/3] iommu: introduce domain attribute for nesting
	IOMMUs
Date: Thu, 25 Sep 2014 16:05:33 +0100
Message-ID: <20140925150532.GO20043@arm.com>
References: <1411550485-32483-1-git-send-email-will.deacon@arm.com>
	<1411550485-32483-2-git-send-email-will.deacon@arm.com>
	<20140925143233.GB8306@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140925143233.GB8306-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 25, 2014 at 03:32:33PM +0100, Joerg Roedel wrote:
> On Wed, Sep 24, 2014 at 10:21:23AM +0100, Will Deacon wrote:
> > Some IOMMUs, such as the ARM SMMU, support two stages of translation.
> > The idea behind such a scheme is to allow a guest operating system to
> > use the IOMMU for DMA mappings in the first stage of translation, with
> > the hypervisor then installing mappings in the second stage to provide
> > isolation of the DMA to the physical range assigned to that virtual
> > machine.
> > 
> > In order to allow IOMMU domains to be used for second-stage translation,
> > this patch adds a new iommu_attr (IOMMU_ATTR_NESTING) for setting
> > second-stage domains prior to device attach. The attribute can also be
> > queried to see if a domain is actually making use of nesting.
> > 
> > Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> > Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> 
> Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Thanks, Joerg.

Will
