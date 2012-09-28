From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] Intel IOMMU patch to reprocess RMRR info
Date: Fri, 28 Sep 2012 19:06:41 +0200
Message-ID: <20120928170641.GF18962@8bytes.org>
References: <uh6q9m8bwu6c2jov69m2aivu.1348847561292@email.android.com>
	<5065D1F5.1090003@hp.com> <20120928170106.GE18962@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
To: Linda Knippers <linda.knippers-VXdhtT5mjnY@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Khan, Shuah" <shuah.khan-VXdhtT5mjnY@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Mingarelli,
	Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 28, 2012 at 07:01:06PM +0200, Joerg Roedel wrote:
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
> for DMA-API mappings and disallow to assign these devices to guests.

Of course I meant "allow to assign these devices to guests."

> For devices where this breaks we can implement some quirk-solution and
> disallow guest assignment. But disallowing assignment of devices with
> RMRR defined in general is pure overkill.
> 
> 
> 	Joerg
> 
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
