From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 06/11] iommu: Add iommu_device_set_fwnode() interface
Date: Fri, 10 Feb 2017 16:22:54 +0100
Message-ID: <20170210152254.GI7339@8bytes.org>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
	<1486639981-32368-7-git-send-email-joro@8bytes.org>
	<417eee8c-4e1b-57f0-2c00-d6c3926ce66d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <417eee8c-4e1b-57f0-2c00-d6c3926ce66d-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Fri, Feb 10, 2017 at 02:16:54PM +0000, Robin Murphy wrote:
> > +static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
> > +					   struct fwnode_handle *fwnode)
> > +{
> > +	iommu->fwnode = fwnode;
> > +}
> 
> Would it make sense to simply make the ops and fwnode additional
> arguments to iommu_device_register() (permitting fwnode to be NULL)?
> AFAICS they should typically all have the same effective lifetime so
> there doesn't seem to be any real need to handle everything separately.

Well, it is not yet clear what other information will end up in
'struct iommu_device', and I don't want to add another parameter to
iommu_device_register for every new struct member.

Also I think having these wrappers is more readable in the code, as it
is clear what the code does without looking up the function prototypes
in the header.

It might make sense to set the mandatory struct members via
iommu_device_register in the future, but we'll see :)


	Joerg
