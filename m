From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] Intel IOMMU patch to reprocess RMRR info
Date: Fri, 28 Sep 2012 11:28:06 -0600
Message-ID: <1348853286.2320.369.camel@ul30vt.home>
References: <uh6q9m8bwu6c2jov69m2aivu.1348847561292@email.android.com>
	<5065D1F5.1090003@hp.com> <20120928170106.GE18962@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120928170106.GE18962-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Khan, Shuah" <shuah.khan-VXdhtT5mjnY@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Mingarelli,
	Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2012-09-28 at 19:01 +0200, Joerg Roedel wrote:
> On Fri, Sep 28, 2012 at 12:36:05PM -0400, Linda Knippers wrote:
> > I can only speak to the HP servers.  We have been shipping devices
> > 'for a while' that provide sensor-type data to the platform.  The
> > device does DMA writes to a range of memory (the RMRR) and
> > iLO does DMA reads of that data.
> 
> And what PCI request-ids are used for these DMA transfers? Are this
> request-ids which belong to devices Linux handles on its own?
> 
> > If we address Alex's comments and we make a change to disallow the
> > devices (non-USB devices?) with RMRRs from being assigned to
> > a guest, will those changes be considered?
> 
> This is overkill in my eyes. It means that *any* device which has an
> RMRR defined, whether it is on your platform or not, can not be assigned
> to a guest.
> 
> I think it is better to have the RMRR regions mapped in the domains used
> for DMA-API mappings and disallow to assign these devices to guests. For
> devices where this breaks we can implement some quirk-solution and
> disallow guest assignment. But disallowing assignment of devices with
> RMRR defined in general is pure overkill.

On the other hand, a blanket blacklist of no assignment of RMRR devices
deters creative uses of RMRRs, which seems like a good thing.  USB
probably needs to be an exception due to widespread usage of RMRRs that
are known to not be needed.  Anything else risks the assigned device
doing autonomous writes to memory, potentially causing corruption.  The
only safe way to prevent that would be to insert a reserved memory range
into the guest to match the RMRR, maybe even identity map it if we care
about the RMRR continuing to work, but that makes hotplug of those
devices nearly impossible.  Thanks,

Alex
