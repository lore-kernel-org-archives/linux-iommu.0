From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 0/3] Support for nesting IOMMUs in VFIO
Date: Wed, 3 Sep 2014 17:04:19 +0100
Message-ID: <20140903160419.GH32378@arm.com>
References: <1409651619-27342-1-git-send-email-will.deacon@arm.com>
	<20140903152241.GK28786@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140903152241.GK28786-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On Wed, Sep 03, 2014 at 04:22:42PM +0100, Joerg Roedel wrote:
> Hi Will,

Hi Joerg,

> On Tue, Sep 02, 2014 at 10:53:36AM +0100, Will Deacon wrote:
> > This is version three of the patches I originally posted here:
> > 
> >   RFCv1: http://permalink.gmane.org/gmane.linux.kernel.iommu/5552
> >   RFCv2: http://permalink.gmane.org/gmane.linux.kernel.iommu/5700
> > 
> > Changes since RFCv2 include:
> > 
> >   - Dropped the RFC tag
> >   - Rebased onto 3.17-rc*
> >   - Iterate the support bus_types (currently just PCI) and check that
> >     nesting is actually supported
> > 
> > The corresponding arm-smmu changes are included to show how the new
> > domain attribute can be used.
> 
> How is this implemented in the SMMU, can there be only one stage2
> mapping, so that a device can be passed through to a KVM guest or can
> there be multiple stage2 mappings in parallel (like with PRI/PASID on
> PCI) to support multiple translation contexts on one device?

The restriction is that a stage-1 context (i.e. set of guest page tables)
can be associated with at most 1 stage-2 context. If a device is capable of
emitting multiple Stream IDs and the guest assigns those to different
stage-1 contexts, then I guess we could use different stage-2 contexts for
them, but it's not something I'd considered.

Note that the stage-2 context is used to walk the stage-1 page tables, so
you always needs the guest memory to be mapped there.

Will
