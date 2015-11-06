From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] Independent use of IOMMU groups
Date: Fri, 6 Nov 2015 13:29:40 +0100
Message-ID: <20151106122939.GA13027@8bytes.org>
References: <1446746079.8831.82.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446746079.8831.82.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On Thu, Nov 05, 2015 at 10:54:39AM -0700, Alex Williamson wrote:
> We have a couple things in-flight that are trying to make use of IOMMU
> groups, independent of the rest of the IOMMU API.  One is the proposed
> VFIO No-IOMMU hack that will create an IOMMU group for a non-IOMMU
> backed device in order to make it operate within vfio and exposed via
> vfio-pci:
> 
> https://lkml.org/lkml/2015/11/4/437

Do you really need iommu-groups for non-IOMMU vfio backend? VFIO has its
own representation of groups (iirc they map 1-1 to iommu-groups). Can
this concept in VFIO not be made more independent of iommu-groups?

I think having iommu-groups in sysfs without an iommu in the system is
pretty confusing for the user. Not to say that the usual iommu grouping
code makes no sense anymore, as there is no isolation at all :)


	Joerg
