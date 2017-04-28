From: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/s390: Fix IOMMU groups
Date: Fri, 28 Apr 2017 15:20:17 +0200
Message-ID: <20170428152017.5e99d67f@thinkpad>
References: <1493306905-32334-1-git-send-email-joro@8bytes.org>
	<1493306905-32334-2-git-send-email-joro@8bytes.org>
	<20170427201142.18d467a3@thinkpad>
	<20170427211232.GF1332@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170427211232.GF1332-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 27 Apr 2017 23:12:32 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Thu, Apr 27, 2017 at 08:11:42PM +0200, Gerald Schaefer wrote:
> > > +void zpci_destroy_iommu(struct zpci_dev *zdev)
> > > +{
> > > +	iommu_group_put(zdev->group);
> > > +	zdev->group = NULL;
> > > +}  
> > 
> > While the rest of this patch doesn't seem to make much of a difference to
> > the current behavior, I'm wondering where this extra iommu_group_put()
> > comes from. It either was erroneously missing before this patch, or it
> > is erroneously introduced by this patch.  
> 
> This is the way to free an iommu-group. It was missing before probably
> because it was unclear whether the add_device function allocated a group
> or not. So there was no way to know if it needs to be put again in the
> remove_device function.

Hmm, for the reference count it should not matter whether a new group was
allocated or an existing group found with iommu_group_get(). Our add_device
callback always gets one reference either from iommu_group_get or _alloc,
and then another one from iommu_group_add_device(), after which the first
reference is put again. So there should always be one reference more after
a successful add_device.

Now I'm wondering where this one reference is put again, and I thought
that happened in the remove_device callback, where we call
iommu_group_remove_device(). Is this not correct? Just want to make sure
that we don't have a refcount issue in the current code.

Regards,
Gerald
