From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] Independent use of IOMMU groups
Date: Fri, 06 Nov 2015 08:35:40 -0700
Message-ID: <1446824140.8831.168.camel@redhat.com>
References: <1446746079.8831.82.camel@redhat.com>
	<20151106122939.GA13027@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151106122939.GA13027-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-11-06 at 13:29 +0100, Joerg Roedel wrote:
> Hi Alex,
> 
> On Thu, Nov 05, 2015 at 10:54:39AM -0700, Alex Williamson wrote:
> > We have a couple things in-flight that are trying to make use of IOMMU
> > groups, independent of the rest of the IOMMU API.  One is the proposed
> > VFIO No-IOMMU hack that will create an IOMMU group for a non-IOMMU
> > backed device in order to make it operate within vfio and exposed via
> > vfio-pci:
> > 
> > https://lkml.org/lkml/2015/11/4/437
> 
> Do you really need iommu-groups for non-IOMMU vfio backend? VFIO has its
> own representation of groups (iirc they map 1-1 to iommu-groups). Can
> this concept in VFIO not be made more independent of iommu-groups?
> 
> I think having iommu-groups in sysfs without an iommu in the system is
> pretty confusing for the user. Not to say that the usual iommu grouping
> code makes no sense anymore, as there is no isolation at all :)

Hi Joerg,

VFIO is really built on iommu groups, so making a vfio group independent
of iommu groups is a difficult proposition.  With introducing the
no-iommu vfio code, I accept that people are going to run userspace
drivers without iommu protection, regardless of whether it's
supportable.  By using the vfio device interface, we're at least pushing
them towards code that does have a supported use case.  So my goal there
is to enable no-iommu mode in a way that is compact (I'm only willing to
invest limited lines of code to enable this) and does not undermine the
foundation of vfio.  I also do everything I can to make it clear that
this is unsafe, from the naming of the opt-in module parameter to the
tainting of the kernel when a no-iommu group is created to the dev_warn
with that group creation and later when the device is opened, using a
differently named vfio device node for the group, and allowing only a
no-iommu IOMMU backend for the group.  There is no chance that a user
can accidentally operate on a no-iommu vfio group and there are
breadcrumbs left behind even in the normal process of using them.  Also,
as I mentioned previously, the lifetime of this no-iommu group is tied
to the device being bound to the vfio driver, so no other drivers would
have access to the iommu group and the user has already had to opt-in
their system and generated a dmesg log and kernel taint before they even
get the chance to be confused by that iommu group.  Thanks,

Alex
