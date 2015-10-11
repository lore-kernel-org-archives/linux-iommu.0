From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] vfio: Include no-iommu mode
Date: Sun, 11 Oct 2015 12:19:54 +0300
Message-ID: <20151011091954.GA27451@redhat.com>
References: <20151009182228.14752.99700.stgit@gimli.home>
	<20151009184110.14752.53531.stgit@gimli.home>
	<561A19DE.8040302@scylladb.com>
	<20151011115503-mutt-send-email-mst@redhat.com>
	<561A25D5.6020906@scylladb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <561A25D5.6020906-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Avi Kivity <avi-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org>
Cc: avi-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, gleb-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, bruce.richardson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gleb-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org, vladz-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Oct 11, 2015 at 12:03:17PM +0300, Avi Kivity wrote:
> 
> 
> On 10/11/2015 11:57 AM, Michael S. Tsirkin wrote:
> >On Sun, Oct 11, 2015 at 11:12:14AM +0300, Avi Kivity wrote:
> >>>   Mixing no-iommu and secure VFIO is
> >>>also unsupported, as are any VFIO IOMMU backends other than the
> >>>vfio-noiommu backend.  Furthermore, unsafe group files are relocated
> >>>to /dev/vfio-noiommu/.  Upon successful loading in this mode, the
> >>>kernel is tainted due to the dummy IOMMU put in place.  Unloading of
> >>>the module in this mode is also unsupported and will BUG due to the
> >>>lack of support for unregistering an IOMMU for a bus type.
> >>I did not see an API for detecting whether memory translation is provided or
> >>not.  We can have the caller guess this by looking at the device name, or by
> >>requiring the user to specify this, but I think it's cleaner to provide
> >>programmatic access to this attribute.
> >It seems that caller can just check for VFIO_NOIOMMU_IOMMU.
> >
> >Isn't this why it's there?
> 
> That's just means the capability is there, not that it's active.

Well it's currently exactly the same.
I guess you can check the return value of VFIO_SET_IOMMU as well.

> But since you must pass the same value to open(), you already know that
> you're using noiommu.
> 
> >VFIO_IOMMU_MAP_DMA, VFIO_IOMMU_ENABLE and VFIO_IOMMU_DISABLE
> >will probably also fail ...
> >
> 
> Don't you have to call MAP_DMA to pin the memory?

Well check it out - the patch in question doesn't implement this ioctl.
In fact it doesn't implement anything except CHECK_EXTENSION.

And this makes sense to me: MAP_DMA
maps a virtual address to io address, and that doesn't
work for the dummy iommu.

You can pin memory using many other ways, including
mlock and hugetlbfs.

-- 
MST
