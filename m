From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] iommu/intel: Exclude devices using RMRRs
 from IOMMU API domains
Date: Thu, 19 Jun 2014 16:41:35 +0200
Message-ID: <CAKMK7uHhNfRn0LD7YQnmkBmK05KDDfeYNVjmpJOxh2cw8qPtyw@mail.gmail.com>
References: <20140613162901.4550.94476.stgit@bling.home>
 <1402983303.3707.94.camel@ul30vt.home>
 <1402988692.7595.106.camel@i7.infradead.org>
 <1403007757.3707.100.camel@ul30vt.home>
 <1403008864.7595.144.camel@i7.infradead.org>
 <1403010982.3707.123.camel@ul30vt.home>
 <20140617134408.GM5821@phenom.ffwll.local>
 <1403128088.3707.223.camel@ul30vt.home>
 <1403142438.3707.234.camel@ul30vt.home>
 <CAKMK7uE6Ab7pvyNvz7sd7QD1ZKDXd6kkEmXHxTzeFCmH1Z_bMQ@mail.gmail.com>
 <1403188160.3707.242.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1403188160.3707.242.camel@ul30vt.home>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: chegu_vinod@hp.com, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 19, 2014 at 4:29 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> But is there a way for software to discover its location from the
> device?  If so, then I think we can recreate all the identity maps we'd
> need for a guest from the device.  If not, then we'd need to figure out
> some IOMMU API extension to handle the mapping.  The spec excerpt above
> seems to indicate that hardware designers decided software doesn't need
> to know about it, but the RMRR seems to be the "oh crap" moment when
> they realized that yes we do need to know about it.  Thanks,

It's all specified somewhere how it exactly works. But we've just had
piles of fun trying to get the stolen range (i.e. for gfx buffer
usage, no the gtt pte block) to work correctly and it's not been fun.
The issue is that these registers are sw-defined and set by the bios.
And the bios team occasionally smokes strong stuff and nilly-willy
changes the definitions without telling anyone ... And we know that
there's more reserved stuff in that stolen range that occasionally
shouldn't be used by the driver. We have regular discussions with
them.

Otoh the same bios teams also set up the RMRR ranges with equallly
predictable results.

I don't have a recommendation here, but expect breakage no matter what you do.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
