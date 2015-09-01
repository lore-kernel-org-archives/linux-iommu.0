From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Building assigned device guest dt node from host device tree ...
Date: Tue, 1 Sep 2015 16:49:41 +0100
Message-ID: <CAFEAcA-JQOaPtymC4xLvXLqrFsU-89+vWWijwT9_ajYuH1FQUQ@mail.gmail.com>
References: <1419024032-1269-1-git-send-email-a.motakis@virtualopensystems.com>
 <55DF07F0.3070405@linaro.org> <1440691887.20355.27.camel@redhat.com>
 <55DF45D0.5040704@linaro.org> <20150830140638.GB24113@cbox>
 <55E48897.4090907@linaro.org> <20150831173359.GA10991@cbox>
 <55E5546C.7040504@linaro.org> <20150901092813.GE10991@cbox>
 <55E5C46A.2050309@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <55E5C46A.2050309@linaro.org>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: Eric Auger <eric.auger@linaro.org>
Cc: iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>, "eric.auger@st.com" <eric.auger@st.com>, "tech@virtualopensystems.com" <tech@virtualopensystems.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: iommu@lists.linux-foundation.org

On 1 September 2015 at 16:29, Eric Auger <eric.auger@linaro.org> wrote:
> - the device directory can be somewhere in /sys/devices/platform, ie.
> can be in sub-directories. The first difficulty is to locate it. Do you
> know any C routing doing find-file matching a file name pattern? Didn't
> find any in qemu, nor in glib.
>
> - I currently prototype this functionality using popen + find. That
> works but relies on "find" executable availability. Is it a valid
> assumption?

This is definitely not an OK way to do it for a non-prototype
solution.

thanks
-- PMM
