From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 0/8] Introduce automatic DMA configuration for IOMMU
	masters
Date: Fri, 5 Dec 2014 12:11:25 +0000
Message-ID: <20141205121125.GJ1630@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<CAOesGMg9BpL3AyDjuAvH_H5fOm-uga+_CZuJZ5p8zpHpJLg0qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMg9BpL3AyDjuAvH_H5fOm-uga+_CZuJZ5p8zpHpJLg0qA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 05, 2014 at 07:12:24AM +0000, Olof Johansson wrote:
> On Mon, Dec 1, 2014 at 8:57 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > Hello again,
> >
> > This is version 6 of the patches previously posted here:
> >
> >   RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
> >   RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
> >   RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
> >   RFCv4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302711.html
> >      v5: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307213.html
> >
> > The only change since v5 is the addition of acks from various maintainers.
> >
> > Now that the ARM bits have rmk's ack and the IOMMU bits have joro's ack,
> > I think this is good for merging via the arm-soc tree.
> >
> > Please let me know if a pull request would be preferable.
> 
> 
> Hi,
> 
> Yes, please collect the acks from the discussion in the last day or so
> and send a pull request (and include Robin's patch, obviously).

Sure, I'm just working out which of Robin's patches to take (if I don't hear
otherwise, it will be the one with Grant's ack on it).

Will
